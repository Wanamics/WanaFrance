tableextension 87150 "wan Fixed Asset" extends "Fixed Asset"
{
    fields
    {
        field(87150; "wan Vehicle Registration ID"; Code[20])
        {
            Caption = 'Vehicle Registration ID';
            DataClassification = ToBeClassified;
        }
        field(87151; "wan Vehicle First Regist. Date"; Date)
        {
            Caption = 'Vehicle First Registration Date';
            DataClassification = ToBeClassified;
        }
        field(87152; "wan Vehicle CO2 Emission"; Integer)
        {
            Caption = 'Vehicle CO2 Emission (g/km)';
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(87153; "wan Vehicle Admin. Power"; Integer)
        {
            Caption = 'Vehicle Admin. Power (cv)';
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(87154; "wan Vehicle Assignment Type"; Enum "wan Vehicle Assignment Type")
        {
            Caption = 'Vehicle Assignment Type';
            DataClassification = ToBeClassified;
        }
        field(87155; "wan Vehicule Tax Starting Date"; Date)
        {
            Caption = 'Vehicule Tax Starting Date';
            DataClassification = ToBeClassified;
        }
        field(87156; "wan Vehicle Assign. Percentage"; Decimal)
        {
            Caption = 'Vehicle Assignment Percentage';
            DataClassification = ToBeClassified;
            BlankZero = true;
            MinValue = 0;
            MaxValue = 100;
        }
        field(87157; "wan Vehicle Tax Category"; Enum "wan Vehicle Tax Category")
        {
            Caption = 'Vehicle Tax Category';
            DataClassification = ToBeClassified;
        }
    }
}
