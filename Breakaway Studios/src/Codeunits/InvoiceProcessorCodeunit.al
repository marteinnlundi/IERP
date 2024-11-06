codeunit 50122 "Invoice Processor"
{
    procedure ImportInvoiceData()
    var
        FlinsleyXMLPort: XmlPort "Flinsley Invoice Import";
        InvoiceTempTable: Record "Flinsley Invoice Temp";
        FilePath: Text;
        InStream: InStream;
    begin
        Message('Starting ImportInvoiceData procedure.');

        // Clear previous data in the temporary table to avoid duplicate records
        InvoiceTempTable.DeleteAll();

        // Request the user to select an XML file for import
        if UploadIntoStream('Select Invoice XML File', '', 'XML files (*.xml)|*.xml', FilePath, InStream) then begin
            Message('File selected: %1', FilePath);

            // Import data using XMLPort
            FlinsleyXMLPort.SetSource(InStream);
            FlinsleyXMLPort.Import();
            Message('XMLPort import completed.');

            // Debug: Check if data was added to the temporary table
            if InvoiceTempTable.FindFirst() then begin
                Message('Invoice data imported successfully:');
                repeat
                    Message('CustomerNo: %1, Project: %2, ProductNumber: %3, Qty: %4, Price: %5, Discount: %6', 
                            InvoiceTempTable."CustomerNo", 
                            InvoiceTempTable."Project",
                            InvoiceTempTable."ProductNumber",
                            InvoiceTempTable."Qty",
                            InvoiceTempTable."Price",
                            InvoiceTempTable."Discount");
                until InvoiceTempTable.Next() = 0;
            end else
                Error('No data was imported into the temporary table. Check XML structure or XMLPort mapping.');
        end else
            Error('File selection was canceled.');
    end;

    procedure CreateSalesInvoice()
    var
        SalesHeader: Record "Sales Header";
        InvoiceTempTable: Record "Flinsley Invoice Temp";
    begin
        Message('Starting CreateSalesInvoice procedure.');

        // Ensure there's data in the temporary table
        if InvoiceTempTable.IsEmpty() then begin
            Error('No data found in the temporary table.');
            exit;
        end;

        // Loop through each record in the temporary table to create invoices
        InvoiceTempTable.FindSet(true);
        repeat
            Message('Creating Sales Header for Customer No: %1', InvoiceTempTable."CustomerNo");

            // Initialize and insert a new Sales Header record
            SalesHeader.Init();
            SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
            SalesHeader."Sell-to Customer No." := InvoiceTempTable."CustomerNo";
            SalesHeader."Sell-to Customer Name" := 'Customer Name Here'; // Replace with actual customer name logic if available
            SalesHeader."Posting Date" := WorkDate(); // Use today's date
            SalesHeader."Due Date" := WorkDate() + 30; // Example due date
            SalesHeader."Currency Code" := ''; // Set currency code if necessary

            SalesHeader.Insert(true); // Insert and commit the Sales Header record

            // Call CreateSalesLines to add lines for this invoice
            CreateSalesLines(SalesHeader);

            Message('Sales Invoice Created for Customer: %1 with Document No: %2', SalesHeader."Sell-to Customer No.", SalesHeader."No.");
        until InvoiceTempTable.Next() = 0;
    end;

    procedure CreateSalesLines(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        InvoiceTempTable: Record "Flinsley Invoice Temp";
    begin
        Message('Starting CreateSalesLines for Document No: %1', SalesHeader."No.");

        // Loop through the temporary table to add each item as a sales line
        InvoiceTempTable.FindSet();
        repeat
            Message('Creating Sales Line for Product No: %1, Quantity: %2', InvoiceTempTable."ProductNumber", InvoiceTempTable."Qty");

            SalesLine.Init();
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Type" := SalesLine."Type"::Item;
            SalesLine."No." := InvoiceTempTable."ProductNumber";
            SalesLine.Quantity := InvoiceTempTable."Qty";
            SalesLine."Unit Price" := InvoiceTempTable."Price";
            SalesLine.Insert(true); // Insert and commit the Sales Line record

        until InvoiceTempTable.Next() = 0;

        Message('Finished creating Sales Lines for Document No: %1', SalesHeader."No.");
    end;
}