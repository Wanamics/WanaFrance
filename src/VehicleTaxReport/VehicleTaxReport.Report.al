report 87150 "wan Vehicle Tax Report"
{
    ApplicationArea = All;
    Caption = 'Vehicle Tax Report';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = '.\src\VehicleTaxReport\VehicleTaxReport.xlsx';
    DefaultLayout = Excel;
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            RequestFilterFields = "No.", "FA Posting Group", "wan Vehicle Registration ID", "wan Vehicle Assignment Type", "wan Vehicle Tax Category";
            column(CompanyName; CompanyName) { }
            column(Year; Year) { }
            column(No; "No.") { }
            column(Description; Description) { }
            column(ProfessionalTax; "Professional Tax") { }
            column(VehicleRegistrationID; "wan Vehicle Registration ID") { }
            column(VehicleFirstRegistrationDate; "wan Vehicle First Regist. Date") { }
            column(VehiculeTaxStartingDate; "wan Vehicule Tax Starting Date") { }
            column(VehicleTaxCategory; "wan Vehicle Tax Category") { }
            column(VehicleCO2Emission; "wan Vehicle CO2 Emission") { }
            column(VehicleAdminPower; "wan Vehicle Admin. Power") { }
            column(VehicleAssignmentType; "wan Vehicle Assignment Type") { }
            column(VehicleAssignmentPercentage; "wan Vehicle Assign. Percentage") { }
            column(AcquisitionDate; FADepreciationBook."Acquisition Date") { }
            column(DisposalDate; FADepreciationBook."Disposal Date") { }
            column(TaxStartingDate; Max("wan Vehicule Tax Starting Date", DMY2Date(1, 1, Year))) { }
            column(TaxEndingDate; Min(FADepreciationBook."Disposal Date", DMY2Date(31, 12, Year))) { }
            trigger OnPreDataItem()
            var
                YearIsNullErr: Label 'Year is null.';
            begin
                if Year = 0 then
                    Error(YearIsNullErr);
            end;

            trigger OnAfterGetRecord()
            begin
                if not FADepreciationBook.Get("No.", FASetup."Default Depr. Book") then
                    CurrReport.Skip();
                if (FADepreciationBook."Disposal Date" <> 0D) and (FADepreciationBook."Disposal Date" < DMY2Date(1, 1, Year)) then
                    CurrReport.Skip;
                if "wan Vehicule Tax Starting Date" > DMY2Date(31, 12, Year) then
                    CurrReport.Skip();
                if "wan Vehicle Assign. Percentage" = 0 then
                    "wan Vehicle Assign. Percentage" := 100;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Year; Year)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
                        MinValue = 2000;
                        BlankZero = true;
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        FASetup.Get();
        FASetup.TestField("Default Depr. Book");
    end;

    var
        Year: Integer;
        FASetup: Record "FA Setup";
        FADepreciationBook: Record "FA Depreciation Book";

    local procedure Max(pDate1: Date; pDate2: Date): Date
    begin
        if pDate1 = 0D then
            Exit(pDate2);
        if pDate1 > pDate2 then
            exit(pDate1)
        else
            exit(pDate2);
    end;

    local procedure Min(pDate1: Date; pDate2: Date): Date
    begin
        if pDate1 = 0D then
            Exit(pDate2);
        if pDate1 < pDate2 then
            exit(pDate1)
        else
            exit(pDate2);
    end;
}
