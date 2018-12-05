# TEST SCENARIO: Red Reversal Posting

## CASE 1: Posting of red reversal while undo purchase receipt 

### Open General Ledger Setup:

-	Show Amounts: choose option All Amounts

### Open Inventory Setup

-	Post Neg. Transfers as Corr.
-	Set field Expected Cost posting to G/L.

### Post Purchase Receipt

-	Choose Vendor No. and all mandatory fields on header.
-	Choose Item and enter Quantity and Direct unit cost on the line.
-	Post Receipt.

### Undo Posted Purchase Receipt

-	Open previously posted purchase receipt.
-	Choose option Undo Receipt.
-	Open Posted Purchase Receipt.
-	Check General Ledger Entries.

## Test case acceptance criteria

-	Open Value Entries. Entries are set as correction.
-	Open General Ledger Entries. All entries are posted as negative amount in debit or credit amount.

## CASE 2: Posting of red reversal while undo sales shipment

### Open General Ledger Setup:

-	Show Amounts: choose option All Amounts

### Post Sales Shipment

-	Choose Customer No. and all mandatory fields on header.
-	Choose Item and enter Quantity and Unit Price on the line.
-	Post Sales Shipment.

### Undo Posted Sales Shipment

-	Open previously posted sales shipment.
-	Choose option Undo Shipment.
-	Open Posted Sales Shipment.
-	Check General Ledger Entries.

## Test case acceptance criteria

-	Open Value Entries. Entries are set as correction.
-	Open General Ledger Entries. All entries are posted as negative amount in debit or credit amount.
