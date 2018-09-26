codeunit 13063402 "Library Setup-adl"
{
    Subtype = Normal;

    var
        LibraryApplicationArea: Codeunit "Library - Application Area";
        LibraryPatterns: Codeunit "Library - Patterns";
        LibraryERM: Codeunit "Library - ERM";
        LibrarySales: Codeunit "Library - Sales";
        LibraryInventory: Codeunit "Library - Inventory";
        LibraryWarehouse: Codeunit "Library - Warehouse";
        LibraryUtility: Codeunit "Library - Utility";

    procedure InitializeCoreSetup(enabled: Boolean);
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        LibraryApplicationArea.EnableFoundationSetup();

        with CoreSetup do begin
            DeleteAll();
            Init();
            "ADL Enabled" := enabled;
            Insert();
        end;
    end;

    procedure InitializeExtendedSetup(enabled: Boolean; UseVATOutputDate: Boolean);
    var
        ExtendedSetup: Record "Extended Setup-Adl";
    begin
        with ExtendedSetup do begin
            DeleteAll();
            if not enabled then exit;
            Init();
            "Use VAT Output Date" := UseVATOutputDate;
            Insert(true);
        end;
    end;

    //TODO: FAS KRD BST VIES UnpaidReceivables

    procedure InitializeBasicSetupTables();
    begin
        LibraryApplicationArea.EnableFoundationSetup();

        InitializeCoreSetup(true);
        InitializeExtendedSetup(true, true);

        LibraryPatterns.SETNoSeries();
        LibrarySales.SetPostedNoSeriesInSetup();
    end;

    procedure CreateGenPostingGroupGetAccounts();
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        GeneralPostingSetup: Record "General Posting Setup";
    begin
        GeneralLedgerSetup.GET();
        GeneralLedgerSetup."Adjust for Payment Disc." := TRUE;
        GeneralLedgerSetup.Modify(true);

        LibraryERM.CreateGenBusPostingGroup(GenBusinessPostingGroup);
        LibraryERM.CreateGenProdPostingGroup(GenProductPostingGroup);
        LibraryERM.CreateGeneralPostingSetup(GeneralPostingSetup, GenBusinessPostingGroup.Code, GenProductPostingGroup.Code);

        with GeneralPostingSetup do begin
            LibraryERM.SetGeneralPostingSetupSalesAccounts(GeneralPostingSetup);
            LibraryERM.SetGeneralPostingSetupSalesPmtDiscAccounts(GeneralPostingSetup);
            LibraryERM.SetGeneralPostingSetupPurchAccounts(GeneralPostingSetup);
            LibraryERM.SetGeneralPostingSetupPurchPmtDiscAccounts(GeneralPostingSetup);
            LibraryERM.SetGeneralPostingSetupInvtAccounts(GeneralPostingSetup);
            LibraryERM.SetGeneralPostingSetupPrepAccounts(GeneralPostingSetup);
            LibraryERM.SetGeneralPostingSetupMfgAccounts(GeneralPostingSetup);
            "Purch. FA Disc. Account" := LibraryERM.CreateGLAccountNo();
            Modify(true);
        end;
    end;

    procedure CreateInventoryPostingSetupGetAccounts();
    var
        Location: Record "Location";
        InventoryPostingGroup: Record "Inventory Posting Group";
        InventoryPostingSetup: Record "Inventory Posting Setup";
    begin
        LibraryWarehouse.CreateLocation(Location);

        LibraryInventory.SetAutomaticCostAdjmtAlways();
        LibraryInventory.SetAutomaticCostPosting(true);

        if not InventoryPostingGroup.FindFirst() then
            LibraryInventory.CreateInventoryPostingGroup(InventoryPostingGroup);

        LibraryInventory.CreateInventoryPostingSetup(InventoryPostingSetup, Location.Code, InventoryPostingGroup.Code);

        with InventoryPostingSetup do begin
            "Inventory Account" := LibraryERM.CreateGLAccountNo();
            "Inventory Account (Interim)" := LibraryERM.CreateGLAccountNo();
            "WIP Account" := LibraryERM.CreateGLAccountNo();
            "Material Variance Account" := LibraryERM.CreateGLAccountNo();
            "Capacity Variance Account" := LibraryERM.CreateGLAccountNo();
            "Mfg. Overhead Variance Account" := LibraryERM.CreateGLAccountNo();
            "Cap. Overhead Variance Account" := LibraryERM.CreateGLAccountNo();
            "Subcontracted Variance Account" := LibraryERM.CreateGLAccountNo();
            Modify(true);
        end;
    end;

    procedure CreateFASInstrument(var FASInstrumentAdl: Record "FAS Instrument-Adl")
    begin
        FASInstrumentAdl.Init();
        FASInstrumentAdl.Type := FASInstrumentAdl.Type::Posting;
        FASInstrumentAdl.Code := LibraryUtility.GenerateRandomCode(
            FASInstrumentAdl.FieldNo(Code), Database::"FAS Instrument-Adl");
        FASInstrumentAdl.Insert();
    end;

    procedure CreateFASSector(var FASSectordl: Record "FAS Sector-Adl")
    begin
        FASSectordl.Init();
        FASSectordl.Type := FASSectordl.Type::Posting;
        FASSectordl.Code := LibraryUtility.GenerateRandomCode(
            FASSectordl.FieldNo(Code), Database::"FAS Instrument-Adl");
        FASSectordl.Insert();
    end;
}