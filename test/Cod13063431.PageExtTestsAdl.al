codeunit 13063431 "Page Extensions Tests-Adl"
{
    Subtype = Test;

    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;
        LibraryTestHelp: Codeunit "Library Test Help-adl";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        LibrarySetupStorage: Codeunit "Library - Setup Storage";
        LibraryUtility: Codeunit "Library - Utility";
        LibraryERMCountryData: Codeunit "Library - ERM Country Data";
        LibraryRandom: Codeunit "Library - Random";
        LibraryERM: Codeunit "Library - ERM";
        LibrarySales: Codeunit "Library - Sales";
        LibraryPurchase: Codeunit "Library - Purchase";
        LibraryInventory: Codeunit "Library - Inventory";
        LibrarySetupAdl: codeunit "Library Setup-adl";
        LibraryFiscalYear: Codeunit "Library - Fiscal Year";
        isInitialized: Boolean;
        OptionCountErr: Label 'The number of options in a field %1 is %2, but should be %3.';

    local procedure Initialize();
    var
    begin
        LibraryVariableStorage.Clear();
        LibrarySetupStorage.Restore();

        if isInitialized then
            exit;

        LibrarySetupAdl.InitializeBasicSetupTables();

        isInitialized := TRUE;
    end;

    [Test]
    procedure CompanyInformationAdl();
    var
        MyRec: Record "Company Information";
        MyTestPage: TestPage "Company Information";
    begin
        Initialize();

        // Prepare Record for the Page
        if not MyRec.Get('') then begin
            MyRec.Init();
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Set random values on all additional fields on page
        MyTestPage."Registration No.-Adl".SetValue(LibraryUtility.GenerateRandomText(20));

        MyTestPage.Close();
    end;

    [Test]
    procedure CurrenciesAdl();
    var
        MyRec: Record "Currency";
        MyTestPage: TestPage "Currencies";
    begin
        Initialize();

        // Prepare Record for the Page
        if NOT MyRec.FindFirst() then begin
            MyRec.Init();
            MyRec.Validate(Code, LibraryUtility.GenerateRandomCode(MyRec.FieldNo(Code), Database::Currency));
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Set random values on all additional fields on page
        MyTestPage."Numeric Code-Adl".SetValue(LibraryUtility.GenerateRandomCode(
            MyRec.FieldNo("Numeric Code-Adl"), Database::Currency));

        MyTestPage.Close();
    end;

    [Test]
    procedure CountriesRegionsAdl();
    var
        MyRec: Record "Country/Region";
        MyTestPage: TestPage "Countries/Regions";
    begin
        Initialize();

        // Prepare Record for the Page
        if NOT MyRec.FindFirst() then begin
            MyRec.Init();
            MyRec.Validate(Code, LibraryUtility.GenerateRandomCode(MyRec.FieldNo(Code), Database::Currency));
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Set random values on all additional fields on page
        MyTestPage."Numeric Code-Adl".SetValue(LibraryUtility.GenerateRandomCode(
            MyRec.FieldNo("Numeric Code-Adl"), Database::Currency));

        MyTestPage.Close();
    end;

    [Test]
    procedure ChartOfAccountsAdl();
    var
        FASInstrumentAdl: Record "FAS Instrument-Adl";
        FASSectorAdl: Record "FAS Sector-Adl";
        MyRec: Record "G/L Account";
        MyTestPage: TestPage "Chart of Accounts";
    begin
        Initialize();

        // Prepare Record for the Page
        PrepareGLAccForFAS(MyRec, FASInstrumentAdl, FASSectorAdl);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Set random values on all additional fields on page 
        MyTestPage."FAS Account-Adl".SetValue(true);
        MyTestPage."FAS Instrument Code-Adl".SetValue(FASInstrumentAdl.Code);
        MyTestPage."FAS Sector Code-Adl".SetValue(FASSectorAdl.Code);

        MyTestPage.Close();
    end;

    [Test]
    procedure GLAccountCardAdl();
    var
        FASInstrumentAdl: Record "FAS Instrument-Adl";
        FASSectorAdl: Record "FAS Sector-Adl";
        MyRec: Record "G/L Account";
        MyTestPage: TestPage "G/L Account Card";
    begin
        Initialize();

        // Prepare Record for the Page
        PrepareGLAccForFAS(MyRec, FASInstrumentAdl, FASSectorAdl);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Set random values on all additional fields on page 
        MyTestPage."FAS Account-Adl".SetValue(true);
        MyTestPage."FAS Instrument Posting-Adl".SetValue(MyRec."FAS Instrument Posting-Adl"::"Code Mandatory");
        MyTestPage."FAS Instrument Code-Adl".SetValue(FASInstrumentAdl.Code);
        MyTestPage."FAS Sector Posting-Adl".SetValue(MyRec."FAS Sector Posting-Adl"::"Code Mandatory");
        MyTestPage."FAS Sector Code-Adl".SetValue(FASSectorAdl.Code);
        MyTestPage."FAS Type-Adl".SetValue(MyRec."FAS Type-Adl"::Assets);

        // Check no. of options for additional option fields
        MyTestPage."FAS Instrument Posting-Adl".Activate();
        if MyTestPage."FAS Instrument Posting-Adl".OptionCount() <> 4 then
            Error(OptionCountErr,
                'FAS Instrument Posting', Mytestpage."FAS Instrument Posting-Adl".OptionCount(), 4);
        MyTestPage."FAS Sector Posting-Adl".Activate();
        if MyTestPage."FAS Sector Posting-Adl".OptionCount() <> 4 then
            Error(OptionCountErr,
                'FAS Sector Posting', Mytestpage."FAS Sector Posting-Adl".OptionCount(), 4);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('FASInstrumentCancelPageHandler,FASSectorCancelPageHandler')]

    procedure GLAccountListAdl();
    var
        FASInstrumentAdl: Record "FAS Instrument-Adl";
        FASSectorAdl: Record "FAS Sector-Adl";
        MyRec: Record "G/L Account";
        MyTestPage: TestPage "G/L Account Card";
    begin
        Initialize();

        // Prepare Record for the Page
        PrepareGLAccForFAS(MyRec, FASInstrumentAdl, FASSectorAdl);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."FAS Account-Adl".Activate();
        MyTestPage."FAS Instrument Code-Adl".Lookup();
        MyTestPage."FAS Sector Code-Adl".Lookup();

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('FASInstrumentCancelPageHandler,FASSectorCancelPageHandler,BSTCancelPageHandler,CountriesRegionsCancelPageHandler')]
    procedure GeneralLedgerEntriesAdl();
    var
        MyRec: Record "G/L Entry";
        MyTestPage: TestPage "General Ledger Entries";
    begin
        Initialize();

        // Prepare Record for the Page
        if not MyRec.FindLast() then begin
            MyRec.Init();
            MyRec."Entry No." := 1;
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."FAS Instrument Code-Adl".Lookup();
        MyTestPage."FAS Sector Code-Adl".Lookup();
        MyTestpage."Country/Region Code-Adl".Lookup();
        MyTestPage."BST Code-Adl".Lookup();

        // Check no. of options for additional option fields
        if MyTestPage."FAS Type-Adl".OptionCount() <> 3 then
            Error(OptionCountErr,
                'FAS Type', Mytestpage."FAS Type-Adl".OptionCount(), 3);

        // Invoke all additional actions
        MyTestPage."ChangeBST-Adl".Invoke();
        MyTestPage."ChangeFinInstr-Adl".Invoke();
        MyTestPage."ChangeFinSect-Adl".Invoke();

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('FASSectorCancelPageHandler,KRDCodesCancelPageHandler,KRDSectorsCancelPageHandler')]
    procedure CustomerCardAdl();
    var
        MyRec: Record "Customer";
        MyTestPage: TestPage "Customer Card";
    begin
        Initialize();

        // Prepare Record for the Page
        LibrarySales.CreateCustomer(MyRec);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."FAS Sector Code-Adl".Lookup();
        MyTestPage."KRD Affiliation Type-Adl".Lookup();
        MyTestPage."KRD Non-Resident Sector Code-Adl".Lookup();

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('FASSectorCancelPageHandler,KRDCodesCancelPageHandler,KRDSectorsCancelPageHandler,CountriesRegionsCancelPageHandler')]
    procedure CustomerLedgerEntryAdl();
    var
        MyRec: Record "Cust. Ledger Entry";
        MyTestPage: TestPage "Customer Ledger Entries";
    begin
        Initialize();

        // Prepare Record for the Page
        if not MyRec.FindLast() then begin
            MyRec.Init();
            MyRec."Entry No." := 1;
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."FAS Sector Code-Adl".Lookup();
        MyTestPage."KRD Affiliation Type-Adl".Lookup();
        MyTestPage."KRD Country/Region Code-Adl".Lookup();
        MyTestPage."KRD Instrument Type-Adl".Lookup();
        MyTestPage."KRD Maturity-Adl".Lookup();
        MyTestPage."KRD Non-Resident Sector Code-Adl".Lookup();
        MyTestPage."KRD Other Changes-Adl".Activate();

        // Check no. of options for additional option fields
        if MyTestPage."KRD Claim/Liability-Adl".OptionCount() <> 3 then
            Error(OptionCountErr,
                'KRD Claim/Liability', Mytestpage."KRD Claim/Liability-Adl".OptionCount(), 3);

        // Invoke all additional actions
        MyTestPage."UnpaidReceivables-Adl".Invoke();

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('FASSectorCancelPageHandler,KRDCodesCancelPageHandler,KRDSectorsCancelPageHandler')]
    procedure VendorCardAdl();
    var
        MyRec: Record "Vendor";
        MyTestPage: TestPage "Vendor Card";
    begin
        Initialize();

        // Prepare Record for the Page
        LibraryPurchase.CreateVendor(MyRec);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."FAS Sector Code-Adl".Lookup();
        MyTestPage."KRD Affiliation Type-Adl".Lookup();
        Mytestpage."KRD Non-Resident Sector Code-Adl".Lookup();
        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('FASSectorCancelPageHandler,KRDCodesCancelPageHandler,KRDSectorsCancelPageHandler,CountriesRegionsCancelPageHandler')]
    procedure VendorLedgerEntryAdl();
    var
        MyRec: Record "Vendor Ledger Entry";
        MyTestPage: TestPage "Vendor Ledger Entries";
    begin
        Initialize();

        // Prepare Record for the Page
        if not MyRec.FindLast() then begin
            MyRec.Init();
            MyRec."Entry No." := 1;
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."FAS Sector Code-Adl".Lookup();
        MyTestPage."KRD Affiliation Type-Adl".Lookup();
        MyTestPage."KRD Country/Region Code-Adl".Lookup();
        MyTestPage."KRD Instrument Type-Adl".Lookup();
        MyTestPage."KRD Maturity-Adl".Lookup();
        MyTestPage."KRD Non-Resident Sector Code-Adl".Lookup();
        MyTestPage."KRD Other Changes-Adl".Activate();

        // Check no. of options for additional option fields
        if MyTestPage."KRD Claim/Liability-Adl".OptionCount() <> 3 then
            Error(OptionCountErr,
                'KRD Claim/Liability', Mytestpage."KRD Claim/Liability-Adl".OptionCount(), 3);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('FASInstrumentCancelPageHandler,FASSectorCancelPageHandler')]
    procedure GeneralJournalAdl();
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        MyRec: Record "Gen. Journal Line";
        MyTestPage: TestPage "General Journal";
    begin
        Initialize();

        // Make sure that for page ID=39 exist only one template and batch
        GenJnlTemplate.SetRange("Page ID", 39);
        GenJnlTemplate.SetRange(Type, GenJnlTemplate.Type::General);
        GenJnlTemplate.DeleteAll();
        LibraryERM.CreateGenJournalTemplate(GenJnlTemplate);
        LibraryERM.CreateGenJournalBatch(GenJnlBatch, GenJnlTemplate.Name);

        // Prepare Record for the Page
        MyRec.Init();
        MyRec."Journal Template Name" := GenJnlBatch."Journal Template Name";
        MyRec."Journal Batch Name" := GenJnlBatch.Name;
        MyRec."Line No." := 10000;
        MyRec.Insert(false);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."Bal. FAS Instrument Code-Adl".Lookup();
        MyTestPage."Bal. FAS Sector Code-Adl".Lookup();
        MyTestPage."FAS Instrument Code-Adl".Lookup();
        MyTestPage."FAS Sector Code-Adl".Lookup();
        MyTestPage."OpenAmounLCYtWithoutUnrealizedERF-Adl".Activate();
        MyTestPage."OriginalDocumentAmountLCY-Adl".Activate();
        MyTestPage."OriginalVATAmountLCY-Adl".Activate();

        // Check no. of options for additional option fields
        if MyTestPage."Bal. FAS Type-Adl".OptionCount() <> 3 then
            Error(OptionCountErr,
                'Bal. FAS Type', Mytestpage."Bal. FAS Type-Adl".OptionCount(), 3);
        if MyTestPage."FAS Type-Adl".OptionCount() <> 3 then
            Error(OptionCountErr,
                'FAS Type', Mytestpage."FAS Type-Adl".OptionCount(), 3);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('NoSeriesListCancelPageHandler,FiscLocationListCancelPageHandler')]
    procedure SalesQuoteAdl();
    var
        MyRec: Record "Sales Header";
        MyTestPage: TestPage "Sales Quote";
    begin
        Initialize();

        // Prepare Record for the Page
        PrepareSalesHeader(MyRec, MyRec."Document Type"::Quote);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."Fisc. Location Code-Adl".Lookup();
        MyTestPage."Fisc. No. Series-Adl".Lookup();
        MyTestPage."Fisc. Subject-Adl".Activate();
        MyTestPage."Fisc. Terminal-Adl".Activate();
        MyTestPage."Full Fisc. Doc. No.-Adl".Activate();

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('NoSeriesListCancelPageHandler,FiscLocationListCancelPageHandler')]
    procedure SalesOrderAdl();
    var
        MyRec: Record "Sales Header";
        MyTestPage: TestPage "Sales Order";
    begin
        Initialize();

        // Prepare Record for the Page
        PrepareSalesHeader(MyRec, MyRec."Document Type"::Order);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."Fisc. Location Code-Adl".Lookup();
        MyTestPage."Fisc. No. Series-Adl".Lookup();
        MyTestPage."Fisc. Subject-Adl".Activate();
        MyTestPage."Fisc. Terminal-Adl".Activate();
        MyTestPage."Full Fisc. Doc. No.-Adl".Activate();
        Mytestpage."VAT Date-Adl".Activate();

        // Check no. of options for additional option fields
        if MyTestPage."Postponed VAT-Adl".OptionCount() <> 2 then
            Error(OptionCountErr,
                'Postponed VAT', Mytestpage."Postponed VAT-Adl".OptionCount(), 2);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('NoSeriesListCancelPageHandler,FiscLocationListCancelPageHandler')]
    procedure SalesInvoiceAdl();
    var
        MyRec: Record "Sales Header";
        MyTestPage: TestPage "Sales Invoice";
    begin
        Initialize();

        // Prepare Record for the Page
        PrepareSalesHeader(MyRec, MyRec."Document Type"::Invoice);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."Fisc. Location Code-Adl".Lookup();
        MyTestPage."Fisc. No. Series-Adl".Lookup();
        MyTestPage."Fisc. Subject-Adl".Activate();
        MyTestPage."Fisc. Terminal-Adl".Activate();
        MyTestPage."Full Fisc. Doc. No.-Adl".Activate();
        Mytestpage."VAT Date-Adl".Activate();

        // Check no. of options for additional option fields
        if MyTestPage."Postponed VAT-Adl".OptionCount() <> 2 then
            Error(OptionCountErr,
                'Postponed VAT', Mytestpage."Postponed VAT-Adl".OptionCount(), 2);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('NoSeriesListCancelPageHandler,FiscLocationListCancelPageHandler,GoodsReturnTypesCancelPageHandler')]
    procedure SalesCreditMemoAdl();
    var
        MyRec: Record "Sales Header";
        MyTestPage: TestPage "Sales Credit Memo";
    begin
        Initialize();

        // Prepare Record for the Page
        PrepareSalesHeader(MyRec, MyRec."Document Type"::"Credit Memo");

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."EU Customs Procedure-Adl".Activate();
        MyTestPage."Fisc. Location Code-Adl".Lookup();
        MyTestPage."Fisc. No. Series-Adl".Lookup();
        MyTestPage."Fisc. Subject-Adl".Activate();
        MyTestPage."Fisc. Terminal-Adl".Activate();
        MyTestPage."Full Fisc. Doc. No.-Adl".Activate();
        MyTestPage."Goods Return Type-Adl".Lookup();
        Mytestpage."VAT Date-Adl".Activate();
        MyTestPage."VAT Correction Date-Adl".Activate();

        // Check no. of options for additional option fields
        if MyTestPage."Postponed VAT-Adl".OptionCount() <> 2 then
            Error(OptionCountErr,
                'Postponed VAT', Mytestpage."Postponed VAT-Adl".OptionCount(), 2);

        MyTestPage.Close();
    end;

    [Test]
    procedure PurchaseOrderAdl();
    var
        MyRec: Record "Purchase Header";
        MyTestPage: TestPage "Purchase Order";
    begin
        Initialize();

        // Prepare Record for the Page
        PreparePurchHeader(MyRec, MyRec."Document Type"::Order);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        Mytestpage."VAT Date-Adl".Activate();
        MyTestPage."VAT Output Date-Adl".Activate();

        // Check no. of options for additional option fields
        if MyTestPage."Postponed VAT-Adl".OptionCount() <> 2 then
            Error(OptionCountErr,
                'Postponed VAT', Mytestpage."Postponed VAT-Adl".OptionCount(), 2);

        MyTestPage.Close();
    end;

    [Test]
    procedure PurchaseInvoiceAdl();
    var
        MyRec: Record "Purchase Header";
        MyTestPage: TestPage "Purchase Invoice";
    begin
        Initialize();

        // Prepare Record for the Page
        PreparePurchHeader(MyRec, MyRec."Document Type"::Invoice);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        Mytestpage."VAT Date-Adl".Activate();
        MyTestPage."VAT Output Date-Adl".Activate();

        // Check no. of options for additional option fields
        if MyTestPage."Postponed VAT-Adl".OptionCount() <> 2 then
            Error(OptionCountErr,
                'Postponed VAT', Mytestpage."Postponed VAT-Adl".OptionCount(), 2);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('GoodsReturnTypesCancelPageHandler')]
    procedure PurchaseCreditMemoAdl();
    var
        MyRec: Record "Purchase Header";
        MyTestPage: TestPage "Purchase Credit Memo";
    begin
        Initialize();

        // Prepare Record for the Page
        PreparePurchHeader(MyRec, MyRec."Document Type"::"Credit Memo");

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."Goods Return Type-Adl".Lookup();
        Mytestpage."VAT Date-Adl".Activate();
        MyTestPage."VAT Output Date-Adl".Activate();

        // Check no. of options for additional option fields
        if MyTestPage."Postponed VAT-Adl".OptionCount() <> 2 then
            Error(OptionCountErr,
                'Postponed VAT', Mytestpage."Postponed VAT-Adl".OptionCount(), 2);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('KRDCodesCancelPageHandler')]
    procedure CustomerPostingGroupsAdl();
    var
        MyRec: Record "Customer Posting Group";
        MyTestPage: TestPage "Customer Posting Groups";
    begin
        Initialize();

        // Prepare Record for the Page
        if not MyRec.FindFirst() then begin
            MyRec.Init();
            MyRec.Validate(Code, LibraryUtility.GenerateRandomCode(MyRec.FieldNo(Code), Database::"Customer Posting Group"));
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."KRD Instrument Type-Adl".Lookup();
        MyTestPage."KRD Maturity-Adl".Lookup();

        // Check no. of options for additional option fields
        if MyTestPage."KRD Claim/Liability-Adl".OptionCount() <> 3 then
            Error(OptionCountErr,
                'KRD Claim/Liability', Mytestpage."KRD Claim/Liability-Adl".OptionCount(), 3);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('KRDCodesCancelPageHandler')]
    procedure VendorPostingGroupsAdl();
    var
        MyRec: Record "Vendor Posting Group";
        MyTestPage: TestPage "Vendor Posting Groups";
    begin
        Initialize();

        // Prepare Record for the Page
        if not MyRec.FindFirst() then begin
            MyRec.Init();
            MyRec.Validate(Code, LibraryUtility.GenerateRandomCode(MyRec.FieldNo(Code), Database::"Vendor Posting Group"));
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."KRD Instrument Type-Adl".Lookup();
        MyTestPage."KRD Maturity-Adl".Lookup();

        // Check no. of options for additional option fields
        if MyTestPage."KRD Claim/Liability-Adl".OptionCount() <> 3 then
            Error(OptionCountErr,
                'KRD Claim/Liability', Mytestpage."KRD Claim/Liability-Adl".OptionCount(), 3);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('VATIdentifiersCancelPageHandler')]
    procedure VATEntriesAdl();
    var
        MyRec: Record "VAT Entry";
        MyTestPage: TestPage "VAT Entries";
    begin
        Initialize();

        // Prepare Record for the Page
        if not MyRec.FindLast() then begin
            MyRec.Init();
            MyRec."Entry No." := 1;
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."EU Customs Procedure-Adl".Activate();
        MyTestPage."Full Fisc. Doc. No.-Adl".Activate();
        MyTestPage."VAT % (retrograde)-Adl".Activate();
        MyTestPage."VAT Base (retro.)-Adl".Activate();
        MyTestPage."VAT Correction Date-Adl".Activate();
        MyTestPage."VAT Identifier-Adl".Lookup();

        // Check no. of options for additional option fields
        if MyTestPage."Postponed VAT-Adl".OptionCount() <> 2 then
            Error(OptionCountErr,
                'Postponed VAT', Mytestpage."Postponed VAT-Adl".OptionCount(), 2);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('FASSectorCancelPageHandler,FASInstrumentCancelPageHandler')]
    procedure BankAccountCardAdl();
    var
        MyRec: Record "Bank Account";
        MyTestPage: TestPage "Bank Account Card";
    begin
        Initialize();

        // Prepare Record for the Page
        if not MyRec.FindLast() then
            LibraryERM.CreateBankAccount(MyRec);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."FAS Instrument Code-Adl".Lookup();
        MyTestPage."FAS Sector Code-Adl".Lookup();

        MyTestPage.Close();
    end;

    [Test]
    procedure SalesReceivablesSetupAdl();
    var
        MyRec: Record "Sales & Receivables Setup";
        MyTestPage: TestPage "Sales & Receivables Setup";
    begin
        Initialize();

        // Prepare Record for the Page
        if not MyRec.Get('') then begin
            MyRec.Init();
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Activate all additional fields on page
        MyTestPage."Ext. Data Start Bal. Date-Adl".Activate();

        MyTestPage.Close();
    end;

    [Test]
    procedure InventorySetupAdl();
    var
        MyRec: Record "Inventory Setup";
        MyTestPage: TestPage "Inventory Setup";
    begin
        Initialize();

        // Prepare Record for the Page
        if not MyRec.Get('') then begin
            MyRec.Init();
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Activate all additional fields on page
        MyTestPage."Post Neg. Transfers as Corr.-Adl".Activate();

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('VATIdentifiersCancelPageHandler')]
    procedure VATPostingSetupAdl();
    var
        MyRec: Record "VAT Posting Setup";
        MyTestPage: TestPage "VAT Posting Setup";
    begin
        Initialize();

        // Prepare Record for the Page
        LibraryERM.FindVATPostingSetup(MyRec, 0);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Activate all additional fields on page
        MyTestPage."VAT % (Informative)-Adl".Activate();
        MyTestPage."VAT % (retrograde)-Adl".Activate();
        MyTestPage."VAT Identifier-Adl".Lookup();
        MyTestPage."VIES Goods-Adl".Activate();

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('VATIdentifiersCancelPageHandler')]
    procedure VATPostingSetupCardAdl();
    var
        MyRec: Record "VAT Posting Setup";
        MyTestPage: TestPage "VAT Posting Setup Card";
    begin
        Initialize();

        // Prepare Record for the Page
        LibraryERM.FindVATPostingSetup(MyRec, 0);

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Activate all additional fields on page
        MyTestPage."VAT % (Informative)-Adl".Activate();
        MyTestPage."VAT % (retrograde)-Adl".Activate();
        MyTestPage."VAT Identifier-Adl".Lookup();
        // MyTestPage."VIES Goods-Adl".Activate(); ???

        MyTestPage.Close();
    end;

    [Test]
    procedure CurrencyCardAdl();
    var
        MyRec: Record "Currency";
        MyTestPage: TestPage "Currency Card";
    begin
        Initialize();

        // Prepare Record for the Page
        if not MyRec.FindFirst() then begin
            MyRec.Init();
            MyRec.Validate(Code, LibraryUtility.GenerateRandomCode(MyRec.FieldNo(Code), Database::Currency));
            MyRec.Insert(false);
        end;

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Set random values on all additional fields on page
        MyTestPage."Numeric Code-Adl".SetValue(LibraryUtility.GenerateRandomCode(
            MyRec.FieldNo("Numeric Code-Adl"), Database::Currency));

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('GoodsReturnTypesCancelPageHandler')]
    procedure SalesReturnOrderAdl();
    var
        MyRec: Record "Sales Header";
        MyTestPage: TestPage "Sales Return Order";
    begin
        Initialize();

        // Prepare Record for the Page
        PrepareSalesHeader(MyRec, MyRec."Document Type"::"Return Order");

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."EU Customs Procedure-Adl".Activate();
        MyTestPage."Goods Return Type-Adl".Lookup();
        MyTestPage."VAT Correction Date-Adl".Activate();
        MyTestPage."VAT Date-Adl".Activate();

        // Check no. of options for additional option fields
        if MyTestPage."Postponed VAT-Adl".OptionCount() <> 2 then
            Error(OptionCountErr,
                'Postponed VAT', Mytestpage."Postponed VAT-Adl".OptionCount(), 2);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('GoodsReturnTypesCancelPageHandler')]
    procedure PurchaseReturnOrderAdl();
    var
        MyRec: Record "Purchase Header";
        MyTestPage: TestPage "Purchase Return Order";
    begin
        Initialize();

        // Prepare Record for the Page
        PreparePurchHeader(MyRec, MyRec."Document Type"::"Return Order");

        // Open Page and go to Record
        MyTestPage.OpenEdit();
        MyTestPage.GoToRecord(MyRec);

        // Lookup or Activate additional fields on page
        MyTestPage."Goods Return Type-Adl".Lookup();
        MyTestPage."VAT Date-Adl".Activate();
        MyTestPage."VAT Output Date-Adl".Activate();

        // Check no. of options for additional option fields
        if MyTestPage."Postponed VAT-Adl".OptionCount() <> 2 then
            Error(OptionCountErr,
                'Postponed VAT', Mytestpage."Postponed VAT-Adl".OptionCount(), 2);

        MyTestPage.Close();
    end;

    [Test]
    [HandlerFunctions('VATBooksAdlCancelPageHandler')]
    procedure AccountantRoleCenterAdl();
    var
        MyTestPage: TestPage "Accountant Role Center";
    begin
        Initialize();

        // Open Page and go to Record
        MyTestPage.OpenEdit();

        // Invoke all additional actions on page
        MyTestPage."VAT Books-Adl".Invoke();

        MyTestPage.Close();
    end;

    local procedure PrepareGLAccForFAS(var GLAcc: Record "G/L Account"; var FASInstrumentAdl: Record "FAS Instrument-Adl"; var FASSectorAdl: Record "FAS Sector-Adl")
    begin
        FASInstrumentAdl.SetRange(Type, FASInstrumentAdl.Type::Posting);
        if not FASInstrumentAdl.FindFirst() then
            LibrarySetupAdl.CreateFASInstrument(FASInstrumentAdl);

        FASSectorAdl.SetRange(Type, FASSectorAdl.Type::Posting);
        if not FASSectorAdl.FindFirst() then
            LibrarySetupAdl.CreateFASSector(FASSectorAdl);

        if NOT GLAcc.FindFirst() then
            LibraryERM.CreateGLAccount(GLAcc);
    end;

    local procedure PrepareSalesHeader(var SalesHeader: Record "Sales Header"; DocumentType: Integer);
    begin
        SalesHeader.SetRange("Document Type", DocumentType);
        if not SalesHeader.FindLast() then begin
            SalesHeader.Init();
            SalesHeader."Document Type" := DocumentType;
            SalesHeader."No." := LibraryUtility.GenerateRandomCode(SalesHeader.FieldNo("No."), Database::"Sales Header");
            SalesHeader.Insert(false);
        end;
    end;

    local procedure PreparePurchHeader(var PurchaseHeader: Record "Purchase Header"; DocumentType: Integer);
    begin
        PurchaseHeader.SetRange("Document Type", DocumentType);
        if not PurchaseHeader.FindLast() then begin
            PurchaseHeader.Init();
            PurchaseHeader."Document Type" := DocumentType;
            PurchaseHeader."No." := LibraryUtility.GenerateRandomCode(PurchaseHeader.FieldNo("No."), Database::"Purchase Header");
            PurchaseHeader.Insert(false);
        end;
    end;

    [ModalPageHandler]
    procedure FASInstrumentCancelPageHandler(var FASInstrumentsAdl: TestPage "FAS Instruments-Adl")
    begin
        FASInstrumentsAdl.Cancel().Invoke();
    end;

    [ModalPageHandler]
    procedure FASSectorCancelPageHandler(var FASSectorsAdl: TestPage "FAS Sectors-Adl")
    begin
        FASSectorsAdl.Cancel().Invoke();
    end;

    [ModalPageHandler]
    procedure BSTCancelPageHandler(var BSTCodesAdl: TestPage "BST Codes-Adl")
    begin
        BSTCodesAdl.Cancel().Invoke();
    end;

    [ModalPageHandler]
    procedure CountriesRegionsCancelPageHandler(var CountriesRegions: TestPage "Countries/Regions")
    begin
        CountriesRegions.Cancel().Invoke();
    end;

    [ModalPageHandler]
    procedure KRDCodesCancelPageHandler(var KRDCodes: TestPage "KRD Codes-Adl")
    begin
        KRDCodes.Cancel().Invoke();
    end;

    [ModalPageHandler]
    procedure KRDSectorsCancelPageHandler(var KRDSectors: TestPage "KRD Sectors-Adl")
    begin
        KRDSectors.Cancel().Invoke();
    end;

    [ModalPageHandler]
    procedure VendorListCancelPageHandler(var VendorList: TestPage "Vendor List")
    begin
        VendorList.Cancel().Invoke();
    end;

    [ModalPageHandler]
    procedure FiscLocationListCancelPageHandler(var FiscLocationList: TestPage "Fisc. Location List-Adl")
    begin
        FiscLocationList.Cancel().Invoke();
    end;

    [ModalPageHandler]
    procedure NoSeriesListCancelPageHandler(var NoSeriesList: TestPage "No. Series List")
    begin
        NoSeriesList.Cancel().Invoke();
    end;

    [ModalPageHandler]
    procedure VATIdentifiersCancelPageHandler(var VATIdentifiersAdl: TestPage "VAT Identifiers-Adl")
    begin
        VATIdentifiersAdl.Cancel().Invoke();
    end;

    [ModalPageHandler]
    procedure GoodsReturnTypesCancelPageHandler(var GoodsReturnTypesAdl: TestPage "Goods Return Types-Adl")
    begin
        GoodsReturnTypesAdl.Cancel().Invoke();
    end;

    [ModalPageHandler]
    procedure VATBooksAdlCancelPageHandler(var VATBooksAdl: TestPage "VAT Books-Adl")
    begin
        VATBooksAdl.Cancel().Invoke();
    end;    
}