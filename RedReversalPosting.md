# TEST SCENARIO: Red Reversal Posting

## CASE: Posting of red reversal when posting as red storno of purchase document

### Open General Ledger Setup:

-	Show Amounts: choose option All Amounts

### Post Purchase Order

-	Choose Vendor No. and all mandatory fields on header
-	Choose Item and enter Quantity and Direct unit cost on the line.
-	Post Purchase Order.

### Post Purchase Return Order:

-	Copy Posted Purchase Invoice from first step. All of data are copied.
-	Correction: set value on Yes.
-	Vendor Cr. Memo No.: Enter Correction 01
-	Post document.

### Error:

-	Open General Ledger Entries.
-	All entries are posted on different side as posted purchase invoice.
