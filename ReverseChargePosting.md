# TEST SCENARIO: Reverse Charge Posting

## CASE 1: Same VAT output date as VAT date

### Assisted Setup:

-	Open Assisted Setup.
-	Choose Set up basic Adriatic Localization.
-	Program opens wizard where you accept warning & privacy note for extension.
-	Go to Next page.
-	Set option Adriatic Localization Enabled on CORE SETUP section.
-	Set option VAT enabled on VAT section.
-	Disable option Use VAT Output Date on VAT section.
-	Choose button Finish to confirm setup.

### VAT posting setup:

-	VAT Bus. Posting Group: Set VAT Bus. Posting Group (A)
-	VAT Prod. Posting Group: Set VAT Prod. Posting Group (A)
-	VAT Calculation Type: Reverse Charge VAT
-	VAT %: Enter percentage
-	VAT % (retrograde): Enter percentage
-	Purchase VAT Account: Set account (1) for posting
-	Sale VAT Account: Set account(2) for posting

### G/L Account:

-	Gen. Prod. Posting Group
-	VAT Prod. Posting Group (A)

### Create Purchase Document with following data:

#### Header

-	Vendor Name: Select vendor from list
-	Posting date: Choose posting date. VAT date and VAT outpute date are same.
-	Postponed VAT: Value is set at Realized VAT by default.
-	Vendor Invoice No.: Enter external document No.

#### Line

-	Type: G/L Account
-	No. G/L Account No.
-	Quantity
-	Direct unit cost excl. VAT

### Post Document

VAT entry:

-	One VAT entry where is VAT Calculation Type Reverse Charge

## CASE 2: Same VAT output date as VAT date

### Assisted Setup:

-	Open Assisted Setup.
-	Choose Set up basic Adriatic Localization.
-	Program opens wizard where you accept warning & privacy note for extension.
-	Go to Next page.
-	Set option Adriatic Localization Enabled on CORE SETUP section.
-	Set option VAT enabled on VAT section.
-	Enable option Use VAT Output Date on VAT section.
-	Choose button Finish to confirm setup.

### VAT posting setup:

-	VAT Bus. Posting Group: Set VAT Bus. Posting Group (A)
-	VAT Prod. Posting Group: Set VAT Prod. Posting Group (A)
-	VAT Calculation Type: Reverse Charge VAT
-	VAT %: Enter percentage
-	VAT % (retrograde): Enter percentage
-	Purchase VAT Account: Set account (1) for posting
-	Sale VAT Account: Set account (2) for posting

### G/L Account:

-	Gen. Prod. Posting Group
-	VAT Prod. Posting Group (A)

### Create Purchase Document with following data:

#### Header

-	Vendor Name: Select vendor from list
-	Posting date: Choose posting date. VAT date and VAT outpute date are same.
-	Postponed VAT: Value is set at Realized VAT by default.
-	Vendor Invoice No.: Enter external document No.

#### Line

-	Type: G/L Account
-	No. G/L Account No.
-	Quantity
-	Direct unit cost excl. VAT

### Post Document

VAT entry:

-	Two VAT entry. Vat calculation type i Normal at both entries. At first Type is Sale, and at second Type is Purchase.
