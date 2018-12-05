# TEST SCENARIO: Forced Debit/Credit Posting

## CASE 1: Post as Credit Amount

### Assisted Setup

-	Open Assisted Setup.
-	Choose Set up basic Adriatic Localization.
-	Program opens wizard where you accept warning & privacy note for extension.
-	Go to Next page.
-	Set option Adriatic Localization Enabled on CORE SETUP section.
-	Set option Force Debit/Credit on GENERAL LEDGER section.
-	Choose button Finish to confirm setup.

### G/L Account Card:

-	Debit/Credit: choose Debit

### Post Journal with data: 

-	Posting Date
-	Account Type: G/L Account
-	Account No.: G/L Account No.
-	Document No.
-	Credit Amount
-	Balance Account Type: G/L Account
-	Balance Account No.: G/L Account No.
-	Post Journal

## Test case acceptance criteria

-	General Ledger Entry is posted to Debit Amount.

## CASE 2: Post as Debit Amount

### G/L Account Card:

-	Debit/Credit: choose Credit

### Post Journal with data: 

-	Posting Date
-	Account Type: G/L Account
-	Account No.: G/L Account No.
-	Document No.
-	Debit Amount
-	Balance Account Type: G/L Account
-	Balance Account No.: G/L Account No.
-	Post Journal

## Test case acceptance criteria

-	General Ledger Entry is posted to Credit Amount.

## CASE 3: Post as Debit or Credit Amount

### G/L Account Card:

-	Debit/Credit: choose Both

### Post Journal with data: 

-	Posting Date
-	Account Type: G/L Account
-	Account No.: G/L Account No.
-	Document No.
-	Credit Amount
-	Balance Account Type: G/L Account
-	Balance Account No.: G/L Account No.
-	Post Journal

## Test case acceptance criteria

-	General Ledger Entry is posted to Credit Amount.
