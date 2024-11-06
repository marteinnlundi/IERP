page 50123 "Invoice Import Page"
{
    PageType = List;
    SourceTable = "Flinsley Invoice Temp";
    ApplicationArea = All;
    UsageCategory = Lists;

    actions
    {
        area(Processing)
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

            action(CreateSalesInvoice)
            {
                ApplicationArea = All;
                Caption = 'Create Sales Invoice';
                trigger OnAction()
                var
                    Processor: Codeunit "Invoice Processor";
                begin
                    Processor.CreateSalesInvoice();
                end;
            }

            action(ProcessInvoices)
            {
                ApplicationArea = All;
                Caption = 'Process Invoices';
                trigger OnAction()
                var
                    Processor: Codeunit "Invoice Processor";
                begin
                    Processor.ImportInvoiceData();
                    Processor.CreateSalesInvoice();
                end;
            }

        }
    }
}
