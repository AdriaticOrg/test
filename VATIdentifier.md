# TEST SCENARIO: VAT Identifier

## Setup

### Enter VAT Identifiers

-	Enter Code and Description for VAT Identifier.

### Enter VAT Posting Setup

-	Choose VAT Business Posting Group and VAT Product Posting Group.
-	Enter VAT Identifier for combination. 

## CASE 1: VAT Identifier on VAT Entries for Sales Invoice

### Post Sales Invoice

-	Choose Customer No.
-	Enter all mandatory data for posting Sales Invoice such as Posting Date, Document Date.
-	Enter Item, Quantity and Unit Price on lines.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.
-	Post Invoice
-	Check VAT Entries for Posted Sales Invoice

### Error:

VAT Identifier is not entered on VAT Entry.

## CASE 2: VAT Identifier on VAT Entries for Purchase Invoice

### Post Purchase Invoice

-	Choose Vendor No.
-	Enter all mandatory data for posting Purchase Invoice such as Posting Date, Document Date.
-	Enter Item, Quantity and Direct Unit Cost on lines.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.
-	Post Invoice
-	Check VAT Entries for Posted Purchase Invoice

### Error:

VAT Identifier is not entered on VAT Entry.

## CASE 3: VAT Identifier on VAT Entries for journals

### Post General Journal

-	Choose G/L Account No.
-	Enter all mandatory data for posting Journal such as Posting Date, Document Number, Amount and Balance Account No.
-	Choose General Posting Type, General Product Posting Group and General Business Posting Group.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.
-	Post Journal
-	Check VAT Entries for Journal

### Error:

VAT Identifier is not entered on VAT Entry.