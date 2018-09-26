codeunit 13063430 "Page Tests-Adl"
{
    Subtype = Test;

    TestPermissions = Disabled;

    var
        //UNUSED//Assert: Codeunit Assert;
        //UNUSED//LibraryTestHelp: Codeunit "Library Test Help-adl";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        LibrarySetupStorage: Codeunit "Library - Setup Storage";
        LibraryUtility: Codeunit "Library - Utility";
        //UNUSED//LibraryERMCountryData: Codeunit "Library - ERM Country Data";
        LibraryRandom: Codeunit "Library - Random";
        LibraryERM: Codeunit "Library - ERM";
        //UNUSED//LibrarySales: Codeunit "Library - Sales";
        //UNUSED//LibraryInventory: Codeunit "Library - Inventory";
        //UNUSED//LibrarySetupAdl: codeunit "Library Setup-adl";
        //UNUSED//LibraryFiscalYear: Codeunit "Library - Fiscal Year";
        isInitialized: Boolean;

    local procedure Initialize();
    var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        LibraryVariableStorage.Clear();
        LibrarySetupStorage.Restore();
        //??SalesHeader.DontNotifyCurrentUserAgain(SalesHeader.GetModifyBillToCustomerAddressNotificationId);
        //??SalesHeader.DontNotifyCurrentUserAgain(SalesHeader.GetModifyCustomerAddressNotificationId);

        if isInitialized then
            exit;

        // LibrarySetupAdl.InitializeBasicSetupTables();

        LibraryERM.FindVATPostingSetup(VATPostingSetup, VATPostingSetup."VAT Calculation Type"::"Normal VAT");

        // LibrarySetupAdl.CreateGenPostingGroupGetAccounts();
        // LibrarySetupAdl.CreateInventoryPostingSetupGetAccounts();

        // LibraryERMCountryData.CreateVATData();
        // LibraryERMCountryData.UpdateGeneralLedgerSetup();
        // LibraryERMCountryData.UpdateSalesReceivablesSetup();
        // LibraryERMCountryData.UpdateGeneralPostingSetup();
        // LibrarySetupStorage.Save(DATABASE::"Sales & Receivables Setup");
        // LibrarySetupStorage.Save(DATABASE::"General Ledger Setup");

        isInitialized := TRUE;
    end;

    [Test]
    procedure GoodsReturnTypesAdl();
    var
        CurrentRec: Record "Goods Return Type-Adl";
        VATBusinessPostingGroup: Record "VAT Business Posting Group";
        CurrentTestPage: TestPage "Goods Return Types-Adl";
        RndCode: code[10];
        RndText: Text;
    begin
        Initialize();
        CurrentTestPage.OpenEdit();
        CurrentTestPage.New();

        RndCode := LibraryUtility.GenerateRandomCode(CurrentRec.FieldNo(Code), Database::"Goods Return Type-Adl");
        CurrentTestPage.Code.Value(RndCode);

        RndText := LibraryUtility.GenerateRandomText(MaxStrLen(CurrentRec.Description));
        CurrentTestPage.Description.Value(RndText);

        VATBusinessPostingGroup.FindFirst();
        CurrentTestPage."VAT Bus. Posting Group".Value(VATBusinessPostingGroup.Code);

        CurrentTestPage.OK().Invoke();
    end;

    [Test]
    procedure VATIdentifiersAdl();
    var
        CurrentRec: Record "VAT Identifier-Adl";
        CurrentTestPage: TestPage "VAT Identifiers-Adl";
        RndCode: code[10];
        RndText: Text;
    begin
        Initialize();
        CurrentTestPage.OpenEdit();
        CurrentTestPage.New();

        RndCode := LibraryUtility.GenerateRandomCode(CurrentRec.FieldNo(Code), Database::"Goods Return Type-Adl");
        CurrentTestPage.Code.Value(RndCode);

        RndText := LibraryUtility.GenerateRandomText(MaxStrLen(CurrentRec.Description));
        CurrentTestPage.Description.Value(RndText);

        CurrentTestPage.OK().Invoke();
    end;

    [Test]
    procedure VATBooksAdl();
    var
        CurrentRec: Record "VAT Book-Adl";
        CurrentTestPage: TestPage "VAT Books-Adl";
        RndCode: code[10];
        RndText: Text;
        RndBoolean: Boolean;
    begin
        Initialize();
        CurrentTestPage.OpenEdit();
        CurrentTestPage.New();

        RndCode := LibraryUtility.GenerateRandomCode(CurrentRec.FieldNo(Code), Database::"VAT Book-Adl");
        CurrentTestPage.Code.Value(RndCode);

        RndText := LibraryUtility.GenerateRandomText(MaxStrLen(CurrentRec.Description));
        CurrentTestPage.Description.Value(RndText);

        RndBoolean := LibraryRandom.RandIntInRange(0, 1) = 0;
        CurrentTestPage."Include in XML".Value(Format(RndBoolean));

        RndText := LibraryUtility.GenerateRandomCode20(CurrentRec.FieldNo("Sorting Appearance"), Database::"VAT Book-Adl");
        CurrentTestPage."Sorting Appearance".Value(RndText);

        RndText := LibraryUtility.GenerateRandomText(MaxStrLen(CurrentRec."Tag Name"));
        CurrentTestPage."Tag Name".Value(RndText);

        CurrentTestPage.OK().Invoke();
    end;

    //TODO:: VATBooks Actions
}