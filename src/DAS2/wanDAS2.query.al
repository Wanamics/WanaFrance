query 87152 "wan DAS2"
{
    Caption = 'DAS2';
    QueryType = API;
    APIPublisher = 'Wanamics';
    APIGroup = 'France';
    APIVersion = 'v1.0';
    EntitySetName = 'Payments';
    EntityName = 'Payment';

    elements
    {
        dataitem(GLAccount; "G/L Account")
        {
            DataItemTableFilter = "Tax Group Code" = filter('<> ''''');
            column(AccountNo; "No.") { }
            column(TaxGroupCode; "Tax Group Code") { }

            dataitem(GLEntry; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = GLAccount."No.";
                DataItemTableFilter = "Source Type" = const(Vendor);
                column(PostingDate; "Posting Date") { Caption = 'Posting Date'; }
                column(DocumentType; "Document Type") { Caption = 'Document Type'; }
                column(DocumentNo; "Document No.") { Caption = 'Document No.'; }
                column(Amount; Amount) { Caption = 'Amount'; }
                dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
                {
                    DataItemLink = "Vendor No." = GLEntry."Source No.", "Document No." = GLEntry."Document No.", "Posting Date" = GLEntry."Posting Date";
                    //column(VendorNo; "Vendor No.") { Caption = 'Vendor No.'; }
                    column(CurrencyCode; "Currency Code") { Caption = 'Currency Code'; }
                    column(ExternalDocumentNo; "External Document No.") { Caption = 'External Document No.'; }
                    column(PurchaseLCY; "Purchase (LCY)") { Caption = 'Purchase (LCY)'; ReverseSign = true; }
                    column(OriginalAmtLCY; "Original Amt. (LCY)") { Caption = 'Original Amt. (LCY)'; ReverseSign = true; }
                    dataitem(DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry")
                    {
                        DataItemLink = "Vendor Ledger Entry No." = VendorLedgerEntry."Entry No.";
                        DataItemTableFilter = "Entry Type" = const(Application);
                        column(AppliedAmountLCY; "Amount (LCY)") { Caption = 'Applied Amount (LCY)'; }

                        dataitem(AppliedEntry; "Vendor Ledger Entry")
                        {
                            DataItemLink = "Entry No." = DetailedVendorLedgEntry."Applied Vend. Ledger Entry No.";
                            column(PaymentAmountLCY; "Amount (LCY)") { Caption = 'Payment Amount (LCY)'; }
                            column(PaymentPostingDate; "Posting Date") { Caption = 'Payment Posting Date'; }
                            dataitem(Vendor; Vendor)
                            {
                                DataItemLink = "No." = VendorLedgerEntry."Vendor No.";
                                column(VendorNumber; "No.") { Caption = 'Vendor No.'; }
                                column(VendorName; "Name") { Caption = 'Name'; }
                                column(VendorEORINumber; "EORI Number") { Caption = 'EORI Number'; }
                            }
                        }
                    }
                }
            }
        }
    }
}
