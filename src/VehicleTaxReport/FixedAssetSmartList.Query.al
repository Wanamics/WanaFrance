query 87150 "wan Fixed Asset Vehicle"
{
    Caption = 'Vehicles';
    QueryCategory = 'Fixed Asset List'; // Not enabled on this one for V21
    elements
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            column(Number; "No.") { }
            column(Description; Description) { }
            column(FAPostingGroup; "FA Posting Group") { }
            column(wanVehicleRegistrationID; "wan Vehicle Registration ID") { }
            column(wanVehicleAdminPower; "wan Vehicle Admin. Power") { }
            column(wanVehicleAssignPercentage; "wan Vehicle Assign. Percentage") { }
            column(wanVehicleAssignmentType; "wan Vehicle Assignment Type") { }
            column(wanVehicleCO2Emission; "wan Vehicle CO2 Emission") { }
            column(wanVehicleFirstRegistDate; "wan Vehicle First Regist. Date") { }
            column(wanVehicleTaxCategory; "wan Vehicle Tax Category") { }
            column(wanVehiculeTaxStartingDate; "wan Vehicule Tax Starting Date") { }
            dataitem(FADepreciationBook; "FA Depreciation Book")
            {
                DataItemLink = "FA No." = FixedAsset."No.";
                DataItemTableFilter = "Default FA Depreciation Book" = const(true);
                column(DepreciationStartingDate; "Depreciation Starting Date") { }
                column(DisposalDate; "Disposal Date") { }
            }
        }
    }
}
