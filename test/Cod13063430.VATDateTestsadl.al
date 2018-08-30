codeunit 13063430 "VAT Date Tests-adl"
{
    Subtype = Test;

    TestPermissions = Disabled;

    var
        isInitialized: Boolean;
        Assert: Codeunit Assert;
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        LibrarySetupStorage: Codeunit "Library - Setup Storage";
        LibraryApplicationArea: Codeunit "Library - Application Area";
        LibraryPatterns: Codeunit "Library - Patterns";
        LibraryERMCountryData: Codeunit "Library - ERM Country Data";
        LibraryRandom: Codeunit "Library - Random";
        LibraryERM: Codeunit "Library - ERM";
        LibrarySales: Codeunit "Library - Sales";
        LibraryInventory: Codeunit "Library - Inventory";
        LibrarySetupAdl: codeunit "Library Setup-adl";
        LibraryFiscalYear: Codeunit "Library - Fiscal Year";

    local procedure Initialize();
    var
        GeneralPostingSetup: Record "General Posting Setup";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        LibraryVariableStorage.Clear;
        LibrarySetupStorage.Restore;
        //??SalesHeader.DontNotifyCurrentUserAgain(SalesHeader.GetModifyBillToCustomerAddressNotificationId);
        //??SalesHeader.DontNotifyCurrentUserAgain(SalesHeader.GetModifyCustomerAddressNotificationId);

        if isInitialized then
            exit;

        LibraryApplicationArea.EnableFoundationSetup;

        LibraryPatterns.SETNoSeries;
        LibrarySales.SetPostedNoSeriesInSetup;
        LibraryERM.FindVATPostingSetup(VATPostingSetup, VATPostingSetup."VAT Calculation Type"::"Normal VAT");

        LibrarySetupAdl.CreateGenPostingGroupGetAccounts;
        LibrarySetupAdl.CreateInventoryPostingSetupGetAccounts;

        LibraryERMCountryData.CreateVATData;
        LibraryERMCountryData.UpdateGeneralLedgerSetup;
        LibraryERMCountryData.UpdateSalesReceivablesSetup;
        LibraryERMCountryData.UpdateGeneralPostingSetup;
        LibrarySetupStorage.Save(DATABASE::"Sales & Receivables Setup");
        LibrarySetupStorage.Save(DATABASE::"General Ledger Setup");

        isInitialized := TRUE;
    end;

    local procedure CreateFiscalYearAndInventoryPeriod() PostingDate: Date;
    var
        InventoryPeriod: Record "Inventory Period";
    begin
        LibraryFiscalYear.CreateFiscalYear;
        PostingDate := LibraryFiscalYear.GetLastPostingDate(FALSE);
        LibraryInventory.CreateInventoryPeriod(InventoryPeriod, PostingDate);
    end;

    [ConfirmHandler]
    procedure ConfirmHandler(ConfirmMessage: Text[1024]; var Result: Boolean);
    begin
        ;
        Result := TRUE;
    end;

    [Test]
    [HandlerFunctions('ConfirmHandler')]
    procedure UpdateVATDateOnSalesInvoicePage();
    var
        Customer: Record Customer;
        SalesInvoicePage: TestPage "Sales Invoice";
        UnitOfMeasure: Record "Unit of Measure";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ItemNo: Code[20];
        Currency: Record Currency;
        DocumentNo: Code[20];
        PostedDocumentNo: Code[20];
        PostingDate: Date;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        // Setup
        Initialize;

        // note: item creation requires unit of measure
        LibraryInventory.FindUnitOfMeasure(UnitOfMeasure);
        ItemNo := LibraryInventory.CreateItemNo();
        PostingDate := CreateFiscalYearAndInventoryPeriod;

        InventoryPostingSetup.FindFirst();
        LibrarySales.CreateCustomerWithLocationCode(Customer, InventoryPostingSetup."Location Code");


        SalesInvoicePage.OpenEdit();
        SalesInvoicePage.New();
        SalesInvoicePage."Sell-to Customer No.".Value(Customer."No.");
        SalesInvoicePage."VAT Date-adl".Value(Format(PostingDate));

        //TODO: The field with ID = 2 is not found on the page. ( ApplicationArea #Advanced )
        //SalesInvoicePage.SalesLines.Type.VALUE(FORMAT(SalesLine.Type::Item));
        SalesInvoicePage.SalesLines."No.".VALUE(ItemNo);
        SalesInvoicePage.SalesLines.Quantity.VALUE(FORMAT(LibraryRandom.RandInt(5)));
        SalesInvoicePage."Currency Code".VALUE(Currency.Code);
        //SalesInvoicePage."Posting Date".SetValue(PostingDate);
        DocumentNo := SalesInvoicePage."No.".VALUE;
        SalesInvoicePage.CLOSE;

        SalesHeader.SetCurrentKey("Document Type", "No.");
        SalesHeader.SetCurrentKey("Document Type", "No.");
        SalesHeader.GET(SalesHeader."Document Type"::Invoice, DocumentNo);
        PostedDocumentNo := LibrarySales.PostSalesDocument(SalesHeader, FALSE, TRUE);
    end;

    [Test]
    [HandlerFunctions('ConfirmHandler')]
    procedure UpdateVATDateOnSalesInvoicePageAndPostSalesInvoice();
    var
        Customer: Record Customer;
        SalesInvoicePage: TestPage "Sales Invoice";
        UnitOfMeasure: Record "Unit of Measure";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ItemNo: Code[20];
        Currency: Record Currency;
        DocumentNo: Code[20];
        PostedDocumentNo: Code[20];
        PostingDate: Date;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        // Setup
        Initialize;

        LibraryInventory.FindUnitOfMeasure(UnitOfMeasure);
        ItemNo := LibraryInventory.CreateItemNo();
        PostingDate := CreateFiscalYearAndInventoryPeriod;

        InventoryPostingSetup.FindFirst();
        LibrarySales.CreateCustomerWithLocationCode(Customer, InventoryPostingSetup."Location Code");

        SalesInvoicePage.OpenEdit();
        SalesInvoicePage.New();
        SalesInvoicePage."Sell-to Customer No.".Value(Customer."No.");
        SalesInvoicePage."VAT Date-adl".Value(Format(PostingDate));

        //TODO: The field with ID = 2 is not found on the page. ( ApplicationArea #Advanced )
        //SalesInvoicePage.SalesLines.Type.VALUE(FORMAT(SalesLine.Type::Item));
        SalesInvoicePage.SalesLines."No.".VALUE(ItemNo);
        SalesInvoicePage.SalesLines.Quantity.VALUE(FORMAT(LibraryRandom.RandInt(5)));
        SalesInvoicePage."Currency Code".VALUE(Currency.Code);
        //SalesInvoicePage."Posting Date".SetValue(PostingDate);
        DocumentNo := SalesInvoicePage."No.".VALUE;

        //TODO: Unhandled UI: Confirm
        //Confirm.Test = T.SalesHeader.DocumentNotPostedClosePageQst ( not public )
        SalesInvoicePage.CLOSE;

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
    procedure Test1();
    begin
        Initialize();
        //LibrarySetupAdl.CreateSetupFotMultiVATComapny();
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