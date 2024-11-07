codeunit 50122 "Invoice Processor"
{
    procedure ImportInvoiceData()
    var
        FlinsleyXMLPort: XmlPort "Flinsley Invoice Import";
        InvoiceTempTable: Record "Flinsley Invoice Temp";
        FilePath: Text;
        InStream: InStream;
    begin
        // Clear previous data in the temporary table to avoid duplicate records
        InvoiceTempTable.DeleteAll();

        // Request the user to select an XML file for import
        if UploadIntoStream('Select Invoice XML File', '', 'XML files (*.xml)|*.xml', FilePath, InStream) then begin

            // Import data using XMLPort
            FlinsleyXMLPort.SetSource(InStream);
            FlinsleyXMLPort.Import();

            // Check if data was added to the temporary table
            if InvoiceTempTable.FindFirst() then
                CreateSalesInvoice()
            else
                Error('No data was imported into the temporary table. Check XML structure or XMLPort mapping.');
        end else
            Error('File selection was canceled.');
    end;

    procedure CreateSalesInvoice()
    var
        SalesHeader: Record "Sales Header";
        InvoiceTempTable: Record "Flinsley Invoice Temp";
    begin

        // Ensure there's data in the temporary table
        if InvoiceTempTable.IsEmpty() then begin
            Error('No data found in the temporary table.');
            exit;
        end;

        // Loop through each record in the temporary table to create invoices
        InvoiceTempTable.FindSet(true);
        repeat
            // Initialize and insert a new Sales Header record
            SalesHeader.Init();
            SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
            SalesHeader.Validate("Sell-to Customer No.", InvoiceTempTable."CustomerNo");
            SalesHeader."Posting Date" := WorkDate(); // Use today's date
            SalesHeader."Due Date" := WorkDate() + 30; // Example due date
            SalesHeader."Currency Code" := ''; // Set currency code if necessary

            SalesHeader.Insert(true); // Insert and commit the Sales Header record

            // Call CreateSalesLines to add lines for this invoice
            CreateSalesLines(SalesHeader);
        until InvoiceTempTable.Next() = 0;
    end;

    procedure CreateSalesLines(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        InvoiceTempTable: Record "Flinsley Invoice Temp";
    begin

        // Loop through the temporary table to add each item as a sales line
        InvoiceTempTable.FindSet();
        repeat
            SalesLine.Init();
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Type" := SalesLine."Type"::Item;
            SalesLine."No." := InvoiceTempTable."ProductNumber";
            SalesLine.Quantity := InvoiceTempTable."Qty";
            SalesLine."Unit Price" := InvoiceTempTable."Price";
            SalesLine.Insert(true); // Insert and commit the Sales Line record
        until InvoiceTempTable.Next() = 0;
    end;
}
