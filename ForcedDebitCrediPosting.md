# TEST SCENARIO: Forced Debit/Credit Posting

## CASE 1

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

### Enter Journal with data: 

-	Posting Date
-	Account Type: G/L Account
-	Account No.: G/L Account No.
-	Document No.
-	Credit Amount
-	Balance Account Type: G/L Account
-	Balance Account No.: G/L Account No.

### Post Journal

### Error: 

-	General Ledger Entry is posted to Credit Amount.

## CASE 2

### G/L Account Card:

-	Debit/Credit: choose Credit

### Enter Journal with data: 

-	Posting Date
-	Account Type: G/L Account
-	Account No.: G/L Account No.
-	Document No.
-	Debit Amount
-	Balance Account Type: G/L Account
-	Balance Account No.: G/L Account No.

### Post Journal

### Error: 

-	General Ledger Entry is posted to Debit Amount.

## CASE 3

### G/L Account Card:

-	Debit/Credit: choose Both

### Enter Journal with data: 

-	Posting Date
-	Account Type: G/L Account
-	Account No.: G/L Account No.
-	Document No.
-	Credit Amount
-	Balance Account Type: G/L Account
-	Balance Account No.: G/L Account No.

### Post Journal

### Error: 

-	General Ledger Entry is posted to Debit Amount.
