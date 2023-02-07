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
            RequestFilterFields = "No.", "FA Posting Group", "FA Posting Date Filter", "wan Vehicle Registration ID", "wan Vehicle Assignment Type", "wan Vehicle Tax Category";
            column(CompanyName; CompanyName) { }
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
            column(TaxStartingDate; Max("wan Vehicule Tax Starting Date", GetRangeMin("FA Posting Date Filter"))) { }
            column(TaxEndingDate; Min(FADepreciationBook."Disposal Date", GetRangeMax("FA Posting Date Filter"))) { }
            trigger OnPreDataItem()
            begin
                if (GetRangeMin("FA Posting Date Filter") = 0D) or (GetRangeMax("FA Posting Date Filter") = 0D) then
                    TestField("FA Posting Date Filter");
            end;

            trigger OnAfterGetRecord()
            begin
                if not FADepreciationBook.Get("No.", FASetup."Default Depr. Book") then
                    CurrReport.Skip();
                if (FADepreciationBook."Disposal Date" <> 0D) and (FADepreciationBook."Disposal Date" < GetRangeMin("FA Posting Date Filter")) then
                    CurrReport.Skip;
                if "wan Vehicule Tax Starting Date" > GetRangeMax("FA Posting Date Filter") then
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        FASetup.Get();
        FASetup.TestField("Default Depr. Book");
    end;

    var
        FASetup: Record "FA Setup";
        FADepreciationBook: Record "FA Depreciation Book";

    local procedure Max(Date1: Date; Date2: Date): Date
    begin
        if Date1 = 0D then
            Exit(Date2);
        if Date1 > Date2 then
            exit(Date1)
        else
            exit(Date2);
    end;

    local procedure Min(Date1: Date; Date2: Date): Date
    begin
        if Date1 = 0D then
            Exit(Date2);
        if Date1 < Date2 then
            exit(Date1)
        else
            exit(Date2);
    end;
}
