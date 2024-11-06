pageextension 50124 "FlinsleySalesInvoiceListExt" extends "Sales Invoice List"
{
    actions
    {
        addlast(processing)
        {
            action(ImportInvoices)
            {
                ApplicationArea = All;
                Caption = 'Import Invoices';
                trigger OnAction()
                var
                    Processor: Codeunit "Invoice Processor";
                begin
                    Processor.ImportInvoiceData();
                end;
            }
        }
    }
}
