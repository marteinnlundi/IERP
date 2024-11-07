page 50123 "Invoice Import Page"
{
    Caption = 'Invoice Import Page';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Flinsley Invoice Temp";
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("CustomerNo" ; Rec."CustomerNo")
                {
                    ApplicationArea = All;
                }
                field("Project"; Rec."Project")
                {
                    ApplicationArea = All;
                }
                field("ProductNumber"; Rec."ProductNumber")
                {
                    ApplicationArea = All;
                }
                field("Qty"; Rec."Qty")
                {
                    ApplicationArea = All;
                }
                field("Price"; Rec."Price")
                {
                    ApplicationArea = All;
                }
                field("Discount"; Rec."Discount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
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

            action(DeleteAllInvoices)
            {
                ApplicationArea = All;
                Caption = 'Delete All Invoices';

                trigger OnAction()
                var
                    TempTable: Record "Flinsley Invoice Temp";
                begin
                    begin
                        TempTable.DeleteAll();
                        Message('All invoices have been deleted from the temporary table.');
                    end;
                end;
            }
        }
    }
}
