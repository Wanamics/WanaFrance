namespace Wanamics.France.DAS2;

using System.Utilities;
using Microsoft.Finance.GeneralLedger.Account;
report 87152 "wan DAS2"
{
    ApplicationArea = All;
    Caption = 'DAS2';
    UsageCategory = Administration;
    DefaultLayout = Excel;
    ExcelLayout = './ReportLayouts/DAS2.xlsx';
    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(number);
            column(CompanyName; CompanyName) { }
            column(GLAccountNo; DAS2Query.AccountNo) { }
            column(TaxGroupCode; DAS2Query.TaxGroupCode) { }
            column(PostingDate; DAS2Query.PostingDate) { }
            column(DocumentType; DAS2Query.DocumentType) { }
            column(DocumentNo; DAS2Query.DocumentNo) { }
            column(Amount; DAS2Query.Amount) { }
            column(CurrencyCode; DAS2Query.CurrencyCode) { }
            column(ExternalDocumentNo; DAS2Query.ExternalDocumentNo) { }
            column(PurchaseLCY; DAS2Query.PurchaseLCY) { }
            column(OriginalAmtLCY; DAS2Query.OriginalAmtLCY) { }
            column(AppliedAmount; DAS2Query.AppliedAmountLCY) { }
            column(PaymentAmount; DAS2Query.PaymentAmountLCY) { }
            column(PaymentPostingDate; DAS2Query.PaymentPostingDate) { }
            column(VendorNumber; DAS2Query.VendorNumber) { }
            column(VendorName; DAS2Query.VendorName) { }
            column(VATRegistrationNo; Das2Query.VendorVATRegistrationNo) { }
            column(VendorEORINumber; DAS2Query.VendorEORINumber) { }
            column(Address; DAS2Query.Address) { }
            column(Address2; DAS2Query.Address2) { }
            column(PostCode; DAS2Query.PostCode) { }
            column(City; DAS2Query.City) { }
            column(CountryRegionCode; DAS2Query.CountryRegionCode) { }
            trigger OnPreDataItem()
            var
                YearIsNullErr: Label 'Year is null.';
                ConfirmMsg: Label 'Do you want to extract payment related to %1 account(s) where %2 is set?';
                GLAccount: Record "G/L Account";
            begin
                if Year = 0 then
                    Error(YearIsNullErr);
                if GuiAllowed then begin
                    GLAccount.SetFilter("Tax Group Code", '<>''''');
                    if not Confirm(ConfirmMsg, false, GLAccount.Count, GLAccount.FieldCaption("Tax Group Code")) then
                        CurrReport.Quit();
                end;
                DAS2Query.SetRange(PaymentPostingDate, DMY2Date(1, 1, Year), DMY2Date(31, 12, Year));
                DAS2Query.Open();
            end;

            trigger OnAfterGetRecord()
            begin
                if not DAS2Query.Read() then
                    CurrReport.Break();
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
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
    var
        DAS2Query: Query "wan DAS2";
        Year: Integer;
}
