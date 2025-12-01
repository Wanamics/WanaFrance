pageextension 87152 "wan G/L Account Card" extends "G/L Account Card"
{
    layout
    {
        modify("Tax Group Code")
        {
            ApplicationArea = All; // SalesTax reused for DAS2
        }
    }
}
