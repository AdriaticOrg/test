# TEST SCENARIO: VAT Date

To enable VAT Date functionality set field "VAT Enabled" on table CoreSetup-Adl that can be accessed through Assisted Setup on "Set up basic Adriatic Localization".

## CASE 1

### Open page Sales Invoice

-	Choose Customer No. on Sales Invoice Header.
-	Enter Posting Date and Document Date on Sales Invoice Header.
-	Enter VAT Date on Sales Invoice Header.
-	Enter Item on Sales Invoice Lines.
-	Enter Quantity and Unit Price on Sales Invoice Lines.


### Post Invoice

### ERROR:

VAT Date is not entered on Posted Sales Invoice Header.

## CASE 2

### Open page Purchase Invoice

-	Choose Vendor No. on Purchase Invoice Header.
-	Enter Posting Date and Document Date on Purchase Invoice Header.
-	Enter VAT Date on Purchase Invoice Header.
-	Enter Item on Purchase Invoice Lines.
-	Enter Quantity and Unit Price on Sales Invoice Lines.

### Post Invoice

### ERROR:

VAT Date is not entered on Posted Purchase Invoice Header.