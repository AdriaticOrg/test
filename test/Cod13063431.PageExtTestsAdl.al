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
        LibraryInventory: Codeunit "Library - Inventory";
        LibrarySetupAdl: codeunit "Library Setup-adl";
        LibraryFiscalYear: Codeunit "Library - Fiscal Year";
        isInitialized: Boolean;

    local procedure Initialize();
    var
    begin
        LibraryVariableStorage.Clear();
        LibrarySetupStorage.Restore();

        if isInitialized then
            exit;

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
        if NOT MyRec.GET('') then
            MyRec.INSERT(false);

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
}