# Test Toolset

This separate app has a purpose to test combination of:
- Base Code (W1)
- Adriatic Localization (code-adl)
- Adriatic Setup (setup-adl)

## Connect to Azure Sandbox

1. Select country:

    Country|Certificate|Application
    -------|-----------|-----------
    Slovenia|[Cert](http://w1-130-24069-si.westeurope.azurecontainer.io:8080/certificate.cer)|[Nav](https://w1-130-24069-si.westeurope.azurecontainer.io/NAV)
    Croatia|[Cert](http://w1-130-24069-hr.westeurope.azurecontainer.io:8080/certificate.cer)|[Nav](https://w1-130-24069-hr.westeurope.azurecontainer.io/NAV)
    Serbia|[Cert](http://w1-130-24069-rs.westeurope.azurecontainer.io:8080/certificate.cer)|[Nav](https://w1-130-24069-rs.westeurope.azurecontainer.io/NAV)

2. Download Certificate from selected country (Cert) and place in local machine under Trusted authorization Root. See also: [How to install certificate](https://msdn.microsoft.com/en-us/library/cc750534.aspx?f=255&MSPPError=-2147217396)
3. Open Application link from selected country (App) and use following passwords.
    > Username: admin<br>
    > Password: Rivo1706
4. Accept the license and you are ready to start Business Central.
5. Note: Those instances will be periodically recreated. That means your data will be lost at next precessing. Protect your data from deletion by exporting data via RapidStart.

> Responsible person: [Gregor Alujevič](https://github.com/gregoral)



## TEST SCENARIOS

### GL

[Unpaid Receivables](UnpaidReceivables.md)<br>

[Forced Debit/Credit Posting](ForcedDebitCrediPosting.md)

### REP

[Detail Trial Balance Extended](DetailTrialBalanceExtended.md)

[KRD Report](KRDReport.md)<br>

[VIES Report](VIESReport.md)<br>

[Delivery Declaration](PDOReport.md)<br>

[FAS Report](FASReport.md)<br>

[BST Report](BSTReport.md)<br>

### SP

[Return Orders](ReturnOrders.md)<br>

[Sales Documents](SalesDocuments.md)

### VAT

[Informative VAT](InformativeVAT.md)<br>

[VAT Books](VATBooks.md)<br>

[VAT Date](VATDate.md)<br>

[Reverse Charge Posting](ReverseChargePosting.md)<br>

[Postponed VAT](PostponedReverseChargePosting.md)