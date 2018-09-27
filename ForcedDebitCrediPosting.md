# TEST SCENARIO: Forced Debit/Credit Posting

## CASE 1

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
