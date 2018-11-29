# TEST SCENARIO: Informative VAT

## CASE: Print VAT Informative VAT on VAT Specification

### 1. Enter VAT Posting Setup

-	Choose VAT Business Posting Group and VAT Product Posting Group.
-	Enter VAT % (Informative) for combination.
-	Field VAT % should be 0.
-	Enter Sales VAT Account.

VAT Bus. Posting Group|VAT Prod. Posting Group|VAT Calculation Type|VAT Identifier|VAT %|VAT % (Informative)|Sales VAT Account
----------------------|-----------------------|--------------------|--------------|-----|-------------------|-----------------
K-DA|ODB-22|Normal VAT|36|0|22|260910
K-DA|ODB-9,5|Normal VAT|35|0|9,5|260910

### 2. Post Sales Invoice

-	Choose domestic Customer No.
-	Enter Item on lines.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.

VAT Bus. Posting Group|VAT Prod. Posting Group|Unit Price Excl. VAT
----------------------|-----------------------|--------------------
K-DA|ODB-22|1.000,00

-	Post Invoice. 

### 3. Check posted entries

-	Check posted General Ledger Entries.

G/L Account No.|Amount
---------------|------
760010|-1.000,00
120010| 1.000,00

-	Check VAT Entries.

VAT Bus. Posting Group|VAT Prod. Posting Group|Type|Base|Amount
----------------------|-----------------------|----|----|------
K-DA|ODB-22|Sale|1.000,00|0,00

###	4. Print Posted Sales Invoice. 

Check VAT Specification about informative VAT that should be on printout.

VAT %|VAT Amount Exl. VAT|VAT Amount|Amount Incl. VAT|VAT % Informative|VAT Amount (Informative)
-:|-:|-:|-:|-:|-:
0|1.000|0,00|1.000,00|22|220,00

## Test case acceptance criteria

-	VAT % (informative) is transferred to Sales Invoice Line and Sales Credit Memo Line.
-	Informative VAT amount and Informative VAT % is printed on Sales Invoice and Sales Credit Memo.
