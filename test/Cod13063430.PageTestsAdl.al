codeunit 13063430 "Page Tests-Adl"
{
    Subtype = Test;

    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;
        //UNUSED//LibraryTestHelp: Codeunit "Library Test Help-adl";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        LibrarySetupStorage: Codeunit "Library - Setup Storage";
        LibraryUtility: Codeunit "Library - Utility";
        //UNUSED//LibraryERMCountryData: Codeunit "Library - ERM Country Data";
        LibraryRandom: Codeunit "Library - Random";
        LibraryERM: Codeunit "Library - ERM";
        LibrarySales: Codeunit "Library - Sales";
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


    /* FAS::Fearure */

    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,UserSetupModalPageHandler,FASSectorsAdlModalPageHandler')]
    procedure FASSetupAdl()
    var
        FASSetupAdlRec: Record "FAS Setup-Adl";
        CurrentUserSetup: Record "User Setup";
        FASSetupTestPage: TestPage "FAS Setup-Adl";
        RndCode: Code[10];
        NoSeriesCode: Code[20];
    begin
        Initialize();

        FASSetupTestPage.OpenNew();

        NoSeriesCode := LibraryERM.CreateNoSeriesCode();
        LibraryvariableStorage.Enqueue(NoSeriesCode);
        FASSetupTestPage."FAS Report No. Series".Lookup();

        CreateOrFindUserSetup(CurrentUserSetup, CopyStr(UserId(), 1, 50));
        LibraryvariableStorage.Enqueue(CurrentUserSetup."User ID");
        FASSetupTestPage."FAS Resp. User ID".Lookup();

        LibraryvariableStorage.Enqueue(CurrentUserSetup."User ID");
        FASSetupTestPage."FAS Prep. By User ID".Lookup();

        LibraryvariableStorage.Enqueue(CurrentUserSetup."User ID");
        FASSetupTestPage."FAS Director User ID".Lookup();

        RndCode := LibraryUtility.GenerateRandomCode(FASSetupAdlRec.FieldNo("Budget User Code"), Database::"FAS Setup-Adl");
        FASSetupTestPage."Budget User Code".SetValue(RndCode);

        LibraryvariableStorage.Enqueue(CreateFASSectorCode());
        FASSetupTestPage."Company Sector Code".Lookup();

        FASSetupTestPage.OK().Invoke();
    end;


    [Test]
    procedure FASSectorAdl()
    var
        FASSectorsRec: Record "FAS Sector-Adl";
        FASSectorsTestPage: TestPage "FAS Sectors-Adl";
        RndCode: Code[10];
        RndText: Text;
        i: Integer;
    begin
        Initialize();

        for i := 1 to LibraryRandom.RandIntInRange(3, 10) do begin
            FASSectorsTestPage.OpenNew();

            RndCode := LibraryUtility.GenerateRandomCode(FASSectorsRec.FieldNo(Code), Database::"FAS Sector-Adl");
            FASSectorsTestPage."Code".SetValue(RndCode);

            RndText := LibraryUtility.GenerateRandomText(LibraryRandom.RandIntInRange(1, 200));
            FASSectorsTestPage.Description.SetValue(RndText);

            FASSectorsTestPage.Type.SetValue(FASSectorsTestPage.Type.GetOption(LibraryRandom.RandIntInRange(1, 2)));

            FASSectorsTestPage.OK().Invoke();
        end;
    end;

    [Test]
    procedure FASInstrumentsAdl()
    var
        FASInstrumentsRec: Record "FAS Instrument-Adl";
        FASInstrumentsTestPage: TestPage "FAS Instruments-Adl";
        RndCode: Code[10];
        RndText: Text;
    begin
        Initialize();

        FASInstrumentsTestPage.OpenNew();

        RndCode := LibraryUtility.GenerateRandomCode(FASInstrumentsRec.FieldNo(Code), Database::"FAS Instrument-Adl");
        FASInstrumentsTestPage."Code".SetValue(RndCode);

        RndText := LibraryUtility.GenerateRandomText(LibraryRandom.RandIntInRange(1, 200));
        FASInstrumentsTestPage.Description.SetValue(RndText);

        FASInstrumentsTestPage.Type.SetValue(FASInstrumentsTestPage.Type.GetOption(LibraryRandom.RandIntInRange(1, 3)));

        RndCode := LibraryUtility.GenerateRandomCode(FASInstrumentsRec.FieldNo("AOP Code"), Database::"FAS Instrument-Adl");
        FASInstrumentsTestPage."AOP Code".SetValue(RndCode);

        FASInstrumentsTestPage.OK().Invoke();
    end;

    [Test]
    procedure FASReportAdl()
    var
        FASSetup: Record "FAS Setup-Adl";
        FASSector: Record "FAS Sector-Adl";
        FASInstrument: Record "FAS Instrument-Adl";
        FASReportAdlRec: Record "FAS Report Header-Adl";
        FASReportTestPage: TestPage "FAS Report-Adl";
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        FASReportCode: Code[20];
        FASPeriodYear: Integer;
        FASPeriodRound: Integer;
        Year: Integer;
        Round: Integer;
        Month: Integer;
        ReportPeriodYearErr: label 'Period year must be equal to year of period start date.';
        ReportPeriodRoundErr: label 'Period round must be equal.';
    begin
        Initialize();

        CreateFASSetup(FASSetup);
        CreateFASSector(FASSector);
        CreateFASInstrument(FASInstrument);

        FASReportTestPage.OpenNew();
        FASReportTestPage."Period Start Date".Activate();

        PeriodStartDate := LibraryRandom.RandDateFromInRange(CalcDate('<-CY>', WorkDate()), 5, 10);
        FASReportTestPage."Period Start Date".SetValue(PeriodStartDate);

        PeriodEndDate := LibraryRandom.RandDateFromInRange(PeriodStartDate, 250, 350);
        FASReportTestPage."Period End Date".SetValue(PeriodEndDate);

        FASReportCode := CopyStr(FASReportTestPage."No.".Value(), 1, MaxStrLen(FASReportCode));
        Evaluate(FASPeriodYear, FASReportTestPage."Period Year".Value());
        Evaluate(FASPeriodRound, FASReportTestPage."Period Round".Value());

        FASReportTestPage.OK().Invoke();

        FASReportAdlRec.Get(FASReportCode);
        Year := Date2DMY(FASReportAdlRec."Period Start Date", 3);
        Round := Date2DMY(FASReportAdlRec."Period Start Date", 2);
        Month := Date2DMY(FASReportAdlRec."Period End Date", 2);
        Round := round((Month / 3), 1, '>');

        Assert.AreEqual(Year, FASPeriodYear, ReportPeriodYearErr);
        Assert.AreEqual(Round, FASPeriodRound, ReportPeriodRoundErr);
    end;

    /* KRD */
    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,KRDCodesModalPageHandler,UserSetupModalPageHandler')]
    procedure KRDSetupAdl()
    var
        CurrentUserSetup: Record "User Setup";
        KRDSetupTestPage: TestPage "KRD Setup-Adl";
        KRDCodeType: Option "Affiliation Type","Instrument Type",Maturity;
        NoSeriesCode: Code[20];
    begin
        Initialize();

        KRDSetupTestPage.OpenNew();

        NoSeriesCode := LibraryERM.CreateNoSeriesCode();
        LibraryvariableStorage.Enqueue(NoSeriesCode);
        KRDSetupTestPage."KRD Report No. Series".Lookup();

        CreateOrFindUserSetup(CurrentUserSetup, CopyStr(UserId(), 1, 50));
        LibraryvariableStorage.Enqueue(CurrentUserSetup."User ID");
        KRDSetupTestPage."KRD Resp. User ID".Lookup();

        LibraryvariableStorage.Enqueue(CurrentUserSetup."User ID");
        KRDSetupTestPage."KRD Prep. By User ID".Lookup();

        //KRDSetupTestPage."KRD Blank LCY Code".setValue('EUR'); //fixed
        //KRDSetupTestPage."KRD Blank LCY Num.".setValue('978'); //fixed

        LibraryvariableStorage.Enqueue(CreateKRDCodesCode(KRDCodeType::"Affiliation Type"));
        KRDSetupTestPage."Default KRD Affiliation Type".Lookup();

        KRDSetupTestPage.OK().Invoke();
    end;

    [Test]
    procedure KRDSectorsAdl()
    var
        KRDSectorsRec: Record "KRD Sector-Adl";
        KRDSectorsTestPage: TestPage "KRD Sectors-Adl";
        RndCode: Code[10];
        RndText: Text;
        i: Integer;
    begin
        Initialize();

        for i := 1 to LibraryRandom.RandIntInRange(3, 10) do begin
            KRDSectorsTestPage.OpenNew();

            RndCode := LibraryUtility.GenerateRandomCode(KRDSectorsRec.FieldNo(Code), Database::"KRD Sector-Adl");
            KRDSectorsTestPage."Code".SetValue(RndCode);

            RndText := LibraryUtility.GenerateRandomText(LibraryRandom.RandIntInRange(1, 200));
            KRDSectorsTestPage.Description.SetValue(RndText);

            KRDSectorsTestPage.Type.SetValue(KRDSectorsTestPage.Type.GetOption(LibraryRandom.RandIntInRange(1, 2)));

            KRDSectorsTestPage.OK().Invoke();
        end;
    end;

    [Test]
    procedure KRDCodesAdl()
    var
        KRDCodeAdlRec: Record "KRD Code-Adl";
        KRDCodesTestPage: TestPage "KRD Codes-Adl";
        RndCode: Code[10];
        RndText: Text;
    begin
        Initialize();

        KRDCodesTestPage.OpenNew();

        KRDCodesTestPage.Type.SetValue(KRDCodesTestPage.Type.GetOption(LibraryRandom.RandIntInRange(1, 3)));

        RndCode := LibraryUtility.GenerateRandomCode(KRDCodeAdlRec.FieldNo(Code), Database::"KRD Code-Adl");
        KRDCodesTestPage."Code".SetValue(RndCode);

        RndText := LibraryUtility.GenerateRandomText(LibraryRandom.RandIntInRange(1, 200));
        KRDCodesTestPage.Description.SetValue(RndText);

        KRDCodesTestPage.OK().Invoke();
    end;

    [Test]
    procedure KRDReportAdl()
    var
        KRDSetup: Record "KRD Setup-Adl";
        KRDSector: Record "KRD Sector-Adl";
        KRDReportAdlRec: Record "KRD Report Header-Adl";
        KRDReportTestPage: TestPage "KRD Report-Adl";
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        KRDReportCode: Code[20];
        KRDPrepUser: Code[100];
        KRDRespUser: Code[100];
    begin
        Initialize();

        CreateKRDSetup(KRDSetup);
        CreateKRDSector(KRDSector);

        KRDReportTestPage.OpenNew();
        KRDReportTestPage."Period Start Date".Activate();

        PeriodStartDate := LibraryRandom.RandDateFromInRange(CalcDate('<-CY>', WorkDate()), 5, 10);
        KRDReportTestPage."Period Start Date".SetValue(PeriodStartDate);

        PeriodEndDate := LibraryRandom.RandDateFromInRange(PeriodStartDate, 250, 350);
        KRDReportTestPage."Period End Date".SetValue(PeriodEndDate);

        KRDReportCode := CopyStr(KRDReportTestPage."No.".Value(), 1, MaxStrLen(KRDReportCode));
        KRDPrepUser := CopyStr(KRDReportTestPage."Prep. By User ID".Value(), 1, MaxStrLen(KRDPrepUser));
        KRDRespUser := CopyStr(KRDReportTestPage."Resp. User ID".Value(), 1, MaxStrLen(KRDRespUser));
        KRDReportTestPage.OK().Invoke();

        KRDReportAdlRec.Get(KRDReportCode);
        Assert.AreEqual(KRDSetup."KRD Prep. By User ID", KRDPrepUser, 'User ID must be the same.');
        Assert.AreEqual(KRDSetup."KRD Prep. By User ID", KRDPrepUser, 'User ID must be the same.');
    end;

    /* BST */
    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,UserSetupModalPageHandler')]
    procedure BSTSetupAdl()
    var
        CurrentUserSetup: Record "User Setup";
        BSTSetupTestPage: TestPage "BST Setup-Adl";
        NoSeriesCode: Code[20];
    begin
        Initialize();

        BSTSetupTestPage.OpenNew();

        NoSeriesCode := LibraryERM.CreateNoSeriesCode();
        LibraryvariableStorage.Enqueue(NoSeriesCode);
        BSTSetupTestPage."BST Report No. Series".Lookup();

        CreateOrFindUserSetup(CurrentUserSetup, CopyStr(UserId(), 1, 50));
        LibraryvariableStorage.Enqueue(CurrentUserSetup."User ID");
        BSTSetupTestPage."BST Resp. User ID".Lookup();

        LibraryvariableStorage.Enqueue(CurrentUserSetup."User ID");
        BSTSetupTestPage."BST Prep. By User ID".Lookup();

        BSTSetupTestPage.OK().Invoke();
    end;

    [Test]
    procedure BSTCodeAdl()
    var
        BSTCodeRec: Record "BST Code-Adl";
        BSTCodesTestPage: TestPage "BST Codes-Adl";
        RndCode: Code[10];
        RndText: Text;
    begin
        Initialize();

        BSTCodesTestPage.OpenNew();

        RndCode := LibraryUtility.GenerateRandomCode(BSTCodeRec.FieldNo(Code), Database::"BST Code-Adl");
        BSTCodesTestPage."Code".SetValue(RndCode);

        RndCode := LibraryUtility.GenerateRandomCode(BSTCodeRec.FieldNo("Serial Num."), Database::"BST Code-Adl");
        BSTCodesTestPage."Serial Num.".SetValue(RndCode);

        RndText := LibraryUtility.GenerateRandomText(LibraryRandom.RandIntInRange(1, 200));
        BSTCodesTestPage.Description.SetValue(RndText);

        BSTCodesTestPage.Type.SetValue(BSTCodesTestPage.Type.GetOption(LibraryRandom.RandIntInRange(1, 2)));

        BSTCodesTestPage.OK().Invoke();
    end;

    [Test]
    procedure BSTReportAdl()
    var
        BSTSetup: Record "BST Setup-Adl";
        BSTCode: Record "BST Code-Adl";
        BSTReportAdlRec: Record "BST Report Header-Adl";
        BSTReportTestPage: TestPage "BST Report-Adl";
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        BSTReportCode: Code[20];
        BSTPrepUser: Code[100];
        BSTRespUser: Code[100];
    begin
        Initialize();

        CreateBSTSetup(BSTSetup);
        CreateBSTCode(BSTCode);

        BSTReportTestPage.OpenNew();
        BSTReportTestPage."Period Start Date".Activate();

        PeriodStartDate := LibraryRandom.RandDateFromInRange(CalcDate('<-CY>', WorkDate()), 5, 10);
        BSTReportTestPage."Period Start Date".SetValue(PeriodStartDate);

        PeriodEndDate := LibraryRandom.RandDateFromInRange(PeriodStartDate, 250, 350);
        BSTReportTestPage."Period End Date".SetValue(PeriodEndDate);

        BSTReportCode := CopyStr(BSTReportTestPage."No.".Value(), 1, MaxStrLen(BSTReportCode));
        BSTPrepUser := CopyStr(BSTReportTestPage."Prep. By User ID".Value(), 1, MaxStrLen(BSTPrepUser));
        BSTRespUser := CopyStr(BSTReportTestPage."Resp. User ID".Value(), 1, MaxStrLen(BSTRespUser));
        BSTReportTestPage.OK().Invoke();

        BSTReportAdlRec.Get(BSTReportCode);
        Assert.AreEqual(BSTSetup."BST Prep. By User ID", BSTPrepUser, 'User ID must be the same.');
        Assert.AreEqual(BSTSetup."BST Prep. By User ID", BSTPrepUser, 'User ID must be the same.');
    end;

    /* VIES */
    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,UserSetupModalPageHandler')]
    procedure VIESSetupAdl()
    var
        CurrentUserSetup: Record "User Setup";
        VIESSetup: Record "VIES Setup-Adl";
        VIESSetupTestPage: TestPage "VIES Setup-Adl";
        NoSeriesCode: Code[20];
    begin
        Initialize();

        VIESSetupTestPage.OpenNew();

        NoSeriesCode := LibraryERM.CreateNoSeriesCode();
        LibraryvariableStorage.Enqueue(NoSeriesCode);
        VIESSetupTestPage."VIES Report No. Series".Lookup();

        CreateOrFindUserSetup(CurrentUserSetup, CopyStr(UserId(), 1, 50));
        LibraryvariableStorage.Enqueue(CurrentUserSetup."User ID");
        VIESSetupTestPage."VIES Resp. User ID".Lookup();

        LibraryvariableStorage.Enqueue(CurrentUserSetup."User ID");
        VIESSetupTestPage."VIES Prep. By User ID".Lookup();

        //VIESSetupTestPage."Default VIES Country".SetValue(format(VIESSetupTestPage."Default VIES Country".GetOption(LibraryRandom.RandIntInRange(1, 3))));
        //VIESSetupTestPage."Default VIES Type".SetValue(format(VIESSetupTestPage."Default VIES Type".GetOption(LibraryRandom.RandIntInRange(1, 3))));

        VIESSetupTestPage.OK().Invoke();
    end;

    [Test]
    procedure VIESReportAdl()
    var
        VIESSetup: Record "VIES Setup-Adl";
        VIESReportAdlRec: Record "VIES Report Header-Adl";
        VIESReportTestPage: TestPage "VIES Report-Adl";
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        VIESReportCode: Code[20];
        VIESPrepUser: Code[100];
        VIESRespUser: Code[100];
    begin
        Initialize();

        CreateVIESSetup(VIESSetup);

        VIESReportTestPage.OpenNew();
        VIESReportTestPage."Period Start Date".Activate();

        PeriodStartDate := LibraryRandom.RandDateFromInRange(CalcDate('<-CY>', WorkDate()), 5, 10);
        VIESReportTestPage."Period Start Date".SetValue(PeriodStartDate);

        PeriodEndDate := LibraryRandom.RandDateFromInRange(PeriodStartDate, 250, 350);
        VIESReportTestPage."Period End Date".SetValue(PeriodEndDate);

        VIESReportCode := CopyStr(VIESReportTestPage."No.".Value(), 1, MaxStrLen(VIESReportCode));
        VIESPrepUser := CopyStr(VIESReportTestPage."Prep. By User ID".Value(), 1, MaxStrLen(VIESPrepUser));
        VIESRespUser := CopyStr(VIESReportTestPage."Resp. User ID".Value(), 1, MaxStrLen(VIESRespUser));
        VIESReportTestPage.OK().Invoke();

        VIESReportAdlRec.Get(VIESReportCode);
        Assert.AreEqual(VIESSetup."VIES Prep. By User ID", VIESPrepUser, 'User ID must be the same.');
        Assert.AreEqual(VIESSetup."VIES Prep. By User ID", VIESPrepUser, 'User ID must be the same.');
    end;

    /* PDO */
    [Test]
    [HandlerFunctions('NoSeriesListModalPageHandler,UserSetupModalPageHandler')]
    procedure PDOSetupAdl()
    var
        CurrentUserSetup: Record "User Setup";
        PDOSetupTestPage: TestPage "PDO Setup-Adl";
        NoSeriesCode: Code[20];
    begin
        Initialize();

        PDOSetupTestPage.OpenNew();

        NoSeriesCode := LibraryERM.CreateNoSeriesCode();
        LibraryvariableStorage.Enqueue(NoSeriesCode);
        PDOSetupTestPage."PDO Report No. Series".Lookup();

        CreateOrFindUserSetup(CurrentUserSetup, CopyStr(UserId(), 1, 50));
        LibraryvariableStorage.Enqueue(CurrentUserSetup."User ID");
        PDOSetupTestPage."PDO Resp. User ID".Lookup();

        LibraryvariableStorage.Enqueue(CurrentUserSetup."User ID");
        PDOSetupTestPage."PDO Prep. By User ID".Lookup();

        PDOSetupTestPage.OK().Invoke();
    end;

    [Test]
    procedure PDOReportAdl()
    var
        PDOSetup: Record "PDO Setup-Adl";
        PDOReportAdlRec: Record "PDO Report Header-Adl";
        PDOReportTestPage: TestPage "PDO Report-Adl";
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        PDOReportCode: Code[20];
        PDOPrepUser: Code[100];
        PDORespUser: Code[100];
    begin
        Initialize();

        CreatePDOSetup(PDOSetup);

        PDOReportTestPage.OpenNew();
        PDOReportTestPage."Period Start Date".Activate();

        PeriodStartDate := LibraryRandom.RandDateFromInRange(CalcDate('<-CY>', WorkDate()), 5, 10);
        PDOReportTestPage."Period Start Date".SetValue(PeriodStartDate);

        PeriodEndDate := LibraryRandom.RandDateFromInRange(PeriodStartDate, 250, 350);
        PDOReportTestPage."Period End Date".SetValue(PeriodEndDate);

        PDOReportCode := CopyStr(PDOReportTestPage."No.".Value(), 1, MaxStrLen(PDOReportCode));
        PDOPrepUser := CopyStr(PDOReportTestPage."Prep. By User ID".Value(), 1, MaxStrLen(PDOPrepUser));
        PDORespUser := CopyStr(PDOReportTestPage."Resp. User ID".Value(), 1, MaxStrLen(PDORespUser));
        PDOReportTestPage.OK().Invoke();

        PDOReportAdlRec.Get(PDOReportCode);
        Assert.AreEqual(PDOSetup."PDO Prep. By User ID", PDOPrepUser, 'User ID must be the same.');
        Assert.AreEqual(PDOSetup."PDO Prep. By User ID", PDOPrepUser, 'User ID must be the same.');
    end;


    //handlers
    [ModalPageHandler]
    procedure NoSeriesListModalPageHandler(var NoSeriesList: TestPage 571);
    begin
        NoSeriesList.filter.SetFilter(Code, LibraryvariableStorage.DequeueText());
        NoSeriesList.OK().Invoke();
    end;

    [ModalPageHandler]
    procedure UserSetupModalPageHandler(var UserSetup: TestPage 119);
    begin
        UserSetup.filter.SetFilter("User ID", LibraryvariableStorage.DequeueText());
        UserSetup.OK().Invoke();
    end;

    [ModalPageHandler]
    procedure FASSectorsAdlModalPageHandler(var FASSectorsAdl: TestPage 13062642);
    begin
        FASSectorsAdl.filter.SetFilter(Code, LibraryvariableStorage.DequeueText());
        FASSectorsAdl.OK().Invoke();
    end;

    [ModalPageHandler]
    procedure KRDCodesModalPageHandler(var KRDCodesAdl: TestPage 13062664)
    begin
        KRDCodesAdl.filter.SetFilter(Code, LibraryvariableStorage.DequeueText());
        KRDCodesAdl.OK().Invoke();
    end;

    //Utillity functions    
    local procedure CreateFASSetup(var FASSetup: Record "FAS Setup-Adl")
    var
        CurrentUserSetup: Record "User Setup";
    begin
        with FASSetup do begin
            Init();
            "FAS Report No. Series" := CreateNoSeriesCodeByParam(true, true);
            CreateOrFindUserSetup(CurrentUserSetup, CopyStr(UserId(), 1, 50));
            "FAS Resp. User ID" := CurrentUserSetup."User ID";
            "FAS Prep. By User ID" := CurrentUserSetup."User ID";
            "FAS Director User ID" := CurrentUserSetup."User ID";
            "Budget User Code" := LibraryUtility.GenerateRandomCode(FASSetup.FieldNo("Budget User Code"),
                                                                    Database::"FAS Setup-Adl");
            "Company Sector Code" := CreateFASSectorCode();
            if not Insert(true) then
                Modify(true);
        end;
    end;

    local procedure CreateFASSector(var FASSectorAdl: Record "FAS Sector-Adl")
    begin
        with FASSectorAdl do begin
            Code := LibraryUtility.GenerateRandomCode(FASSectorAdl.FieldNo(Code), Database::"FAS Sector-Adl");
            Description := CopyStr(LibraryUtility.GenerateRandomText(LibraryRandom.RandIntInRange(1, 200)), 1, 200);
            Type := FASSectorAdl.Type::Posting;
            Insert();
        end;
    end;

    local procedure CreateFASInstrument(var FASInstrumentAdl: Record "FAS Instrument-Adl")
    begin
        with FASInstrumentAdl do begin
            Code := LibraryUtility.GenerateRandomCode(FASInstrumentAdl.FieldNo(Code),
                                                      Database::"FAS Instrument-Adl");
            Description := CopyStr(LibraryUtility.GenerateRandomText(LibraryRandom.RandIntInRange(1, 200)), 1, 200);
            Type := FASInstrumentAdl.Type::Posting;
            "AOP Code" := LibraryUtility.GenerateRandomCode(FASInstrumentAdl.FieldNo("AOP Code"),
                                                            Database::"FAS Instrument-Adl");
            Insert();
        end;
    end;

    local procedure CreateVIESSetup(var VIESSetup: Record "VIES Setup-Adl")
    var
        CurrentUserSetup: Record "User Setup";
    begin
        with VIESSetup do begin
            Init();
            "VIES Report No. Series" := CreateNoSeriesCodeByParam(true, true);
            CreateOrFindUserSetup(CurrentUserSetup, CopyStr(UserId(), 1, 50));
            "VIES Resp. User ID" := CurrentUserSetup."User ID";
            "VIES Prep. By User ID" := CurrentUserSetup."User ID";

            "VIES Company Branch Code" := LibraryUtility.GenerateRandomCode(VIESSetup.FieldNo("VIES Company Branch Code"),
                                                                    Database::"VIES Setup-Adl");
            "Default VIES Country" := LibraryRandom.RandIntInRange(1, 3);
            "Default VIES Type" := LibraryRandom.RandIntInRange(1, 3);

            if not Insert(true) then
                Modify(true);
        end;
    end;

    local procedure CreatePDOSetup(var PDOSetup: Record "PDO Setup-Adl")
    var
        CurrentUserSetup: Record "User Setup";
    begin
        with PDOSetup do begin
            Init();
            "PDO Report No. Series" := CreateNoSeriesCodeByParam(true, true);
            CreateOrFindUserSetup(CurrentUserSetup, CopyStr(UserId(), 1, 50));
            "PDO Resp. User ID" := CurrentUserSetup."User ID";
            "PDO Prep. By User ID" := CurrentUserSetup."User ID";
            PDOSetup."PDO VAT Ident. Filter Code" := LibraryUtility.GenerateRandomCode(PDOSetup.FieldNo("PDO VAT Ident. Filter Code"),
                                                                    Database::"PDO Setup-Adl");
            if not Insert(true) then
                Modify(true);
        end;
    end;

    local procedure CreateNoSeriesCodeByParam(Default: Boolean; Manual: Boolean): Code[20];
    var
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
    begin
        LibraryUtility.CreateNoSeries(NoSeries, Default, Manual, false);
        LibraryUtility.CreateNoSeriesLine(NoSeriesLine, NoSeries.Code, '', '');
        exit(NoSeries.Code);
    end;

    local procedure CreateFASSectorCode(): Code[10]
    var
        FASSectorAdl: Record "FAS Sector-Adl";
    begin
        FASSectorAdl.Init();
        FASSectorAdl.Code := LibraryUtility.GenerateRandomCode(FASSectorAdl.FieldNo(Code), Database::"FAS Sector-Adl");
        FASSectorAdl.Description := CopyStr(LibraryUtility.GenerateRandomText(LibraryRandom.RandIntInRange(1, 200)), 1, 200); //CodeAnalyzer
        if FASSectorAdl.Insert(true) then
            exit(FASSectorAdl.Code);
    end;

    local procedure CreateKRDCodesCode(KRDType: Integer): Code[10]
    var
        KRDCodeAdl: Record "KRD Code-Adl";
    begin
        KRDCodeAdl.Init();
        KRDCodeAdl.Type := KRDType;
        KRDCodeAdl.Code := LibraryUtility.GenerateRandomCode(KRDCodeAdl.FieldNo(Code), Database::"FAS Sector-Adl");
        KRDCodeAdl.Description := CopyStr(LibraryUtility.GenerateRandomText(LibraryRandom.RandIntInRange(1, 200)), 1, 200); //CodeAnalyzer
        if KRDCodeAdl.Insert(true) then
            exit(KRDCodeAdl.Code);
    end;

    local procedure CreateKRDSetup(var KRDSetup: Record "KRD Setup-Adl")
    var
        CurrentUserSetup: Record "User Setup";
    begin
        with KRDSetup do begin
            Init();
            "KRD Report No. Series" := CreateNoSeriesCodeByParam(true, true);
            CreateOrFindUserSetup(CurrentUserSetup, CopyStr(UserId(), 1, 50));
            "KRD Resp. User ID" := CurrentUserSetup."User ID";
            "KRD Prep. By User ID" := CurrentUserSetup."User ID";
            "KRD Blank LCY Code" := 'EUR'; //no lookup on page
            "KRD Blank LCY Num." := '978';
            if not Insert(true) then
                Modify(true);
        end;
    end;

    local procedure CreateKRDSector(var KRDSectorAdl: Record "KRD Sector-Adl")
    begin
        with KRDSectorAdl do begin
            Code := LibraryUtility.GenerateRandomCode(KRDSectorAdl.FieldNo(Code), Database::"KRD Sector-Adl");
            Description := CopyStr(LibraryUtility.GenerateRandomText(LibraryRandom.RandIntInRange(1, 200)), 1, 200);
            Type := KRDSectorAdl.Type::Posting;
            Insert();
        end;
    end;

    local procedure CreateBSTSetup(var BSTSetup: Record "BST Setup-Adl")
    var
        CurrentUserSetup: Record "User Setup";
    begin
        with BSTSetup do begin
            Init();
            "BST Report No. Series" := CreateNoSeriesCodeByParam(true, true);
            CreateOrFindUserSetup(CurrentUserSetup, CopyStr(UserId(), 1, 50));
            "BST Resp. User ID" := CurrentUserSetup."User ID";
            "BST Prep. By User ID" := CurrentUserSetup."User ID";
            if not Insert(true) then
                Modify(true);
        end;
    end;

    local procedure CreateBSTCode(var BSTCodeAdl: Record "BST Code-Adl")
    begin
        with BSTCodeAdl do begin
            Code := LibraryUtility.GenerateRandomCode(BSTCodeAdl.FieldNo(Code), Database::"BST Code-Adl");
            Description := CopyStr(LibraryUtility.GenerateRandomText(LibraryRandom.RandIntInRange(1, 100)), 1, MaxStrLen(Description));
            Type := BSTCodeAdl.Type::Posting;
            "Serial Num." := LibraryUtility.GenerateRandomCode(BSTCodeAdl.FieldNo("Serial Num."), Database::"BST Code-Adl");
            Insert();
        end;
    end;


    local procedure CreateOrFindUserSetup(var UserSetup: Record "User Setup"; UserName: Text[50]);
    begin
        if not GetUserSetup(UserSetup, Copystr(UserName, 1, 50)) then
            CreateUserSetup(UserSetup, Copystr(UserName, 1, 50), '');
    end;

    local procedure CreateUserSetup(var UserSetup: Record 91; UserID: Code[50]; ApproverID: Code[50]);
    VAR
        SalespersonPurchaser: Record 13;
    begin
        LibrarySales.CreateSalesperson(SalespersonPurchaser);
        UserSetup.VALIDATE("Salespers./Purch. Code", SalespersonPurchaser.Code);
        UserSetup."User ID" := UserID;
        UserSetup."Approver ID" := ApproverID;
        UserSetup.insert(true);
    end;

    local procedure GetUserSetup(var UserSetup: Record "User Setup"; WindowsUserName: Text[208]): Boolean;
    var
        User: Record 2000000120;
    begin
        if GetNonWindowsUser(User, WindowsUserName) THEN
            UserSetup.Setrange("User ID", User."User Name")
        else
            UserSetup.Setrange("User ID", WindowsUserName);
        exit(UserSetup.FindFirst());
    end;

    local procedure GetNonWindowsUser(var User: Record 2000000120; UserName: Text[208]): Boolean;
    begin
        User.Setrange("User Name", UserName);
        exit(User.FindSet());
    end;

}