pageextension 87150 "wan Fixed Asset Card" extends "Fixed Asset Card"
{
    layout
    {
        addlast(content)
        {
            group("wanVehicle")
            {
                Caption = 'Vehicle';

                field("wan Vehicle Registration ID"; Rec."wan Vehicle Registration ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Registration ID field.';
                }
                field("wan Vehicle First Registr. Date"; Rec."wan Vehicle First Regist. Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle First Registration Date field.';
                }
                field("wan Vehicule Tax Starting Date"; Rec."wan Vehicule Tax Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicule Tax Starting Date field.';
                }
                field("wan Vehicle CO2 Emission (g/km)"; Rec."wan Vehicle CO2 Emission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle CO2 Emission (g/km) field.';
                }
                field("wan Vehicle Tax Category"; Rec."wan Vehicle Tax Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Tax Category field.';
                }
                field("wan Vehicle Admin. Power (cv)"; Rec."wan Vehicle Admin. Power")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Admin. Power (cv) field.';
                }
                field("wan Vehicle Assignment Type"; Rec."wan Vehicle Assignment Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Assignment Type field.';
                }
                field("wan Vehicle Assignment Percentage"; Rec."wan Vehicle Assign. Percentage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Assignment Percentage field.';
                }
            }
        }
    }
}
