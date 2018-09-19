codeunit 13063435 "VAT Date Tests-Adl"
{
    Subtype = Test;

    TestPermissions = Disabled;

    var
        Assert: Codeunit Assert;
        LibraryTestHelp: Codeunit "Library Test Help-adl";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        LibrarySetupStorage: Codeunit "Library - Setup Storage";
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
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        LibraryVariableStorage.Clear();
        LibrarySetupStorage.Restore();
        //??SalesHeader.DontNotifyCurrentUserAgain(SalesHeader.GetModifyBillToCustomerAddressNotificationId);
        //??SalesHeader.DontNotifyCurrentUserAgain(SalesHeader.GetModifyCustomerAddressNotificationId);

        if isInitialized then
            exit;

        LibrarySetupAdl.InitializeBasicSetupTables();

        LibraryERM.FindVATPostingSetup(VATPostingSetup, VATPostingSetup."VAT Calculation Type"::"Normal VAT");

        LibrarySetupAdl.CreateGenPostingGroupGetAccounts();
        LibrarySetupAdl.CreateInventoryPostingSetupGetAccounts();

        LibraryERMCountryData.CreateVATData();
        LibraryERMCountryData.UpdateGeneralLedgerSetup();
        LibraryERMCountryData.UpdateSalesReceivablesSetup();
        LibraryERMCountryData.UpdateGeneralPostingSetup();
        LibrarySetupStorage.Save(DATABASE::"Sales & Receivables Setup");
        LibrarySetupStorage.Save(DATABASE::"General Ledger Setup");

        isInitialized := TRUE;
    end;

    local procedure CreateFiscalYearAndInventoryPeriod() PostingDate: Date;
    var
        InventoryPeriod: Record "Inventory Period";
    begin
        LibraryFiscalYear.CreateFiscalYear();
        PostingDate := LibraryFiscalYear.GetLastPostingDate(FALSE);
        LibraryInventory.CreateInventoryPeriod(InventoryPeriod, PostingDate);
    end;

    procedure CreateItemSalesEntities();
    var
        Customer: Record Customer;
        UnitOfMeasure: Record "Unit of Measure";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        ItemNo: Code[20];
        PostingDate: Date;
    begin
        // note: item creation requires unit of measure
        LibraryInventory.FindUnitOfMeasure(UnitOfMeasure);
        ItemNo := LibraryInventory.CreateItemNo();
        PostingDate := CreateFiscalYearAndInventoryPeriod();

        InventoryPostingSetup.FindFirst();
        LibrarySales.CreateCustomerWithLocationCode(Customer, InventoryPostingSetup."Location Code");
    end;

    [ConfirmHandler]
    procedure ConfirmHandler(ConfirmMessage: Text[1024]; var Result: Boolean);
    begin
        Result := TRUE;
    end;

    [Test]
    procedure TestCreateItemSalesEntities();
    begin
        Initialize();
        CreateItemSalesEntities();
    end;

    [Test]
    [HandlerFunctions('ConfirmHandler')]
    procedure CreateSalesInvoiceUsingSalesInvoicePage();
    var
        Customer: Record Customer;
        Currency: Record Currency;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        SalesInvoicePage: TestPage "Sales Invoice";
        ItemNo: Code[20];
        DocumentNo: Code[20];
    begin
        // Setup
        Initialize();
        CreateItemSalesEntities();
        ItemNo := LibraryInventory.CreateItemNo();
        InventoryPostingSetup.FindFirst();
        LibrarySales.CreateCustomerWithLocationCode(Customer, InventoryPostingSetup."Location Code");

        SalesInvoicePage.OpenEdit();
        SalesInvoicePage.New();
        SalesInvoicePage."Sell-to Customer No.".Value(Customer."No.");

        SalesInvoicePage.SalesLines."No.".VALUE(ItemNo);
        SalesInvoicePage.SalesLines.Quantity.VALUE(FORMAT(LibraryRandom.RandInt(5)));
        SalesInvoicePage."Currency Code".VALUE(Currency.Code);
        DocumentNo := LibraryTestHelp.ToCode20(SalesInvoicePage."No.".VALUE());
        SalesInvoicePage.Release.Invoke();
        SalesInvoicePage.CLOSE();
    end;

    [Test]
    [HandlerFunctions('ConfirmHandler')]
    procedure UpdateVATDateOnSalesInvoicePage();
    var
        Customer: Record Customer;
        Currency: Record Currency;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        SalesInvoicePage: TestPage "Sales Invoice";
        ItemNo: Code[20];
        DocumentNo: Code[20];
        PostingDate: Date;
    begin
        // Setup
        Initialize();
        CreateItemSalesEntities();
        ItemNo := LibraryInventory.CreateItemNo();
        InventoryPostingSetup.FindFirst();
        LibrarySales.CreateCustomerWithLocationCode(Customer, InventoryPostingSetup."Location Code");

        SalesInvoicePage.OpenEdit();
        SalesInvoicePage.New();
        SalesInvoicePage."Sell-to Customer No.".Value(Customer."No.");
        SalesInvoicePage."VAT Date-adl".Value(Format(PostingDate));

        SalesInvoicePage.SalesLines."No.".VALUE(ItemNo);
        SalesInvoicePage.SalesLines.Quantity.VALUE(FORMAT(LibraryRandom.RandInt(5)));
        SalesInvoicePage."Currency Code".VALUE(Currency.Code);
        DocumentNo := LibraryTestHelp.ToCode20(SalesInvoicePage."No.".VALUE());
        SalesInvoicePage.Release.Invoke();
        SalesInvoicePage.CLOSE();
    end;

    [Test]
    [HandlerFunctions('ConfirmHandler')]
    procedure UpdateVATDateOnSalesInvoicePageAndPostSalesInvoice();
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        SalesInvoicePage: TestPage "Sales Invoice";
        ItemNo: Code[20];
        DocumentNo: Code[20];
        PostedDocumentNo: Code[20];
        PostingDate: Date;
    begin
        // Setup
        Initialize();
        CreateItemSalesEntities();
        ItemNo := LibraryInventory.CreateItemNo();
        InventoryPostingSetup.FindFirst();
        LibrarySales.CreateCustomerWithLocationCode(Customer, InventoryPostingSetup."Location Code");

        SalesInvoicePage.OpenEdit();
        SalesInvoicePage.New();
        SalesInvoicePage."Sell-to Customer No.".Value(Customer."No.");
        SalesInvoicePage."VAT Date-adl".Value(Format(PostingDate));

        SalesInvoicePage.SalesLines."No.".VALUE(ItemNo);
        SalesInvoicePage.SalesLines.Quantity.VALUE(FORMAT(LibraryRandom.RandInt(5)));
        SalesInvoicePage."Currency Code".VALUE(Currency.Code);
        DocumentNo := LibraryTestHelp.ToCode20(SalesInvoicePage."No.".VALUE());

        SalesInvoicePage.CLOSE();

        SalesHeader.SetCurrentKey("Document Type", "No.");
        SalesHeader.SetCurrentKey("Document Type", "No.");
        SalesHeader.GET(SalesHeader."Document Type"::Invoice, DocumentNo);
        PostedDocumentNo := LibrarySales.PostSalesDocument(SalesHeader, FALSE, TRUE);

        SalesInvoiceHeader.SetCurrentKey("No.");
        SalesInvoiceHeader.GET(PostedDocumentNo);

        //TODO: REMOVE! ( DEBUG.CODE )
        //Error('VATDate.dbg: PostedVATDate=%1', SalesInvoiceHeader."VAT Date-adl");
        Assert.AreEqual(PostingDate, SalesInvoiceHeader."VAT Date-adl",
          STRSUBSTNO('%1 not equal to %2', SalesInvoiceHeader.FieldCaption("VAT Date-adl"), SalesInvoiceHeader.FieldCaption("Posting Date")));

        //VerifyCurrencyInSalesLine(SalesLine."Document Type"::Invoice,DocumentNo,Resource."No.",Currency.Code);
    end;

    [Test]
    [HandlerFunctions('ConfirmHandler')]
    procedure UpdateVATDateOnSalesInvoicePageAndPostSalesInvoice2();
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        SalesInvoicePage: TestPage "Sales Invoice";
        ItemNo: Code[20];
        DocumentNo: Code[20];
        PostedDocumentNo: Code[20];
        PostingDate: Date;
    begin
        // Setup
        Initialize();
        CreateItemSalesEntities();
        ItemNo := LibraryInventory.CreateItemNo();
        InventoryPostingSetup.FindFirst();
        LibrarySales.CreateCustomerWithLocationCode(Customer, InventoryPostingSetup."Location Code");

        SalesInvoicePage.OpenEdit();
        SalesInvoicePage.New();
        SalesInvoicePage."Sell-to Customer No.".Value(Customer."No.");
        SalesInvoicePage."VAT Date-adl".Value(Format(PostingDate));

        SalesInvoicePage.SalesLines."No.".VALUE(ItemNo);
        SalesInvoicePage.SalesLines.Quantity.VALUE(FORMAT(LibraryRandom.RandInt(5)));
        SalesInvoicePage."Currency Code".VALUE(Currency.Code);
        DocumentNo := LibraryTestHelp.ToCode20(SalesInvoicePage."No.".VALUE());

        SalesInvoicePage.CLOSE();

        SalesHeader.SetCurrentKey("Document Type", "No.");
        SalesHeader.SetCurrentKey("Document Type", "No.");
        SalesHeader.GET(SalesHeader."Document Type"::Invoice, DocumentNo);
        PostedDocumentNo := LibrarySales.PostSalesDocument(SalesHeader, FALSE, TRUE);

        SalesInvoiceHeader.SetCurrentKey("No.");
        SalesInvoiceHeader.GET(PostedDocumentNo);

        //TODO: REMOVE! ( DEBUG.CODE )
        //Error('VATDate.dbg: PostedVATDate=%1', SalesInvoiceHeader."VAT Date-adl");
        Assert.AreEqual(PostingDate, SalesInvoiceHeader."VAT Date-adl",
          STRSUBSTNO('%1 not equal to %2', SalesInvoiceHeader.FieldCaption("VAT Date-adl"), SalesInvoiceHeader.FieldCaption("Posting Date")));

        //VerifyCurrencyInSalesLine(SalesLine."Document Type"::Invoice,DocumentNo,Resource."No.",Currency.Code);
    end;

    [Test]
    procedure Test2();
    begin
        Initialize();
        //LibrarySetupAdl.CreateSetupForMicroSPNoFiscalization();
    end;

    [Test]
    procedure Test3();
    begin
        Initialize();
        //LibrarySetupAdl.CreateSetupForMicroSPNoFiscalization();
    end;
}