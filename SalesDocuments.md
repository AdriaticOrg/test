# TEST SCENARIO: Sales Documents

## CASE 1: Print Posted Sales Invoice

### Report Selection

-	Open page Report Selection - Sales.
-	Choose option Invoice on field Usage. Enter Report ID 13062751 to print Sales Invoice with additional data.
-	Choose button Finish to confirm setup.

Usage|Report ID
-----|---------
Invoice|13062751
Credit Memo|13062752
Shipment|13062753

### Posted Sales Invoice

-	Open Posted Sales Invoices.
-	Choose Posted Sales Invoice.
-	Print Document.

## Test case acceptance criteria

-	Place of issue is printed on document.
-	Date of issue is printed on document.
-	Shipment Date is printed on document.
-	VAT registration for customer is printed on document.
-	VAT Date is printed on document.
-	VAT specification (also informative VAT) is printed on document.

VAT %|VAT Amount Exl. VAT|VAT Amount|Amount Incl. VAT|VAT % Informative|VAT Amount (Informative)
-:|-:|-:|-:|-:|-:
0|1.000|0,00|1.000,00|22|220,00

## CASE 2: Print Posted Sales Credit Memo

### Report Selection

-	Open page Report Selection - Sales.
-	Choose option Credit Memo on field Usage. Enter Report ID 13062752 to print Sales Credit Memo with additional data.
-	Choose button Finish to confirm setup.

### Open Posted Sales Credit Memo

-	Choose Posted Sales Credit Memo
-	Print Document.

## Test case acceptance criteria

-	Place of issue is printed on document.
-	Date of issue is printed on document.
-	Shipment Date is printed on document.
-	VAT registration for customer is printed on document.
-	VAT Date is printed on document.
-	VAT specification (also informative VAT) is printed on document.

VAT %|VAT Amount Exl. VAT|VAT Amount|Amount Incl. VAT|VAT % Informative|VAT Amount (Informative)
-:|-:|-:|-:|-:|-:
0|1.000|0,00|1.000,00|22|220,00

## CASE 3:  Print Posted Shipment

### Report Selection

-	Open page Report Selection - Sales.
-	Choose option Shipment on field Usage. Enter Report ID 13062753 to print Shipment with additional data.
-	Choose button Finish to confirm setup.

### Open Posted Shipment

-	Choose Posted Sales Shipment
-	Print Document.

## Test case acceptance criteria

-	Place of issue is printed on document.
-	Date of issue is printed on document.
-	Shipment Date is printed on document.