pageextension 87151 "wan User Setup" extends "User Setup"
{
    actions
    {
        addlast(Processing)
        {
            action(wanClearAllowPosting)
            {
                ApplicationArea = All;
                Caption = 'Clear Allow Posting From/To';
                Image = Period;

                trigger OnAction()
                var
                    lRec: Record "User Setup";
                begin
                    CurrPage.SetSelectionFilter(lRec);
                    lRec.ModifyAll("Allow Posting From", 0D, false);
                    lRec.ModifyAll("Allow Posting To", 0D, false);
                end;
            }
        }
        addlast(Promoted)
        {
            actionref(wanClearAllowPostingPromoted; wanClearAllowPosting) { }
        }
    }
}
