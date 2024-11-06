xmlport 50120 "Flinsley Invoice Import"
{
    Direction = Import;

    schema
    {
        textelement("Flinsley")
        {
            tableelement("Invoice"; "Flinsley Invoice Temp")
            {
                fieldelement("CustomerNo"; "Invoice".CustomerNo) { }
                fieldelement("Project"; "Invoice".Project) { }
                fieldelement("ResourceType"; "Invoice".ResourceType) { }
                fieldelement("ProductNumber"; "Invoice".ProductNumber) { }
                fieldelement("Qty"; "Invoice".Qty) { }
                fieldelement("Price"; "Invoice".Price) { }
                fieldelement("Discount"; "Invoice".Discount) { }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Invoice Group")
                {
                    field("CustomerNo"; "Invoice".CustomerNo) { }
                    field("Project"; "Invoice".Project) { }
                    field("ResourceType"; "Invoice".ResourceType) { }
                    field("ProductNumber"; "Invoice".ProductNumber) { }
                    field("Qty"; "Invoice".Qty) { }
                    field("Price"; "Invoice".Price) { }
                    field("Discount"; "Invoice".Discount) { }
                }
            }
        }
    }
}
