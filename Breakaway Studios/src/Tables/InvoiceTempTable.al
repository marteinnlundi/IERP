table 50121 "Flinsley Invoice Temp"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "CustomerNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Project"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "ResourceType"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "ProductNumber"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}
