# TEST SCENARIO: Postponed VAT

## CASE 1 

### VAT date is different than posting date and output VAT date

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
-	Reverse Chrg. VAT Acc.: Set account (2) for posting
-	Purch. VAT Unreal. Account: Set account for unrealized VAT
-	Reverse Charge VAT Unreal. Acc: Set account for unrealized reverse charge VAT

### G/L Account:

-	Gen. Prod. Posting Group
-	VAT Prod. Posting Group (A)

### Create Purchase Document with data:

#### Header

-	Vendor Name: Select vendor from list
-	Posting date: Choose posting date. VAT output date is same.
-	VAT date: VAT date is different then posting date.
-	Postponed VAT: Value is set at Postponed VAT by changing VAT date.
-	Vendor Invoice No.: Enter external document No.

#### Line

-	Type: G/L Account
-	No.: G/L Account No.
-	Quantity
-	Direct unit cost excl. VAT

### Post Document

VAT entry:

-	Two VAT entries where is VAT Calculation Type Reverse Charge. First is posted at posting date on document and Postponed VAT is set at Postponed. Second is posted at VAT date and Postponed VAT is set at Realized VAT.

## CASE 2 

VAT date is different than posting date and output VAT date is different than VAT date and posting date.

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
-	Purchase VAT Account: Set account (1) for posting VAT
-	Sale VAT Account.: Set account (2) for posting output VAT
-	Purch. VAT Unreal. Account: Set account for unrealized VAT
-	Sale VAT Unreal. Account: Set account for unrealized output VAT

#### G/L Account:

-	Gen. Prod. Posting Group
-	VAT Prod. Posting Group (A)

### Create Purchase Document with data:

#### Header

-	Vendor Name: Select vendor from list
-	Posting date: Choose posting date. 
-	VAT date: VAT date is different then posting date.
-	VAT output date: Output VAT date is different then VAT date and posting date
-	Postponed VAT: Value is set at Postponed VAT by changing VAT date.
-	Vendor Invoice No.: Enter external document No.

#### Line

-	Type: G/L Account
-	No.: G/L Account No.
-	Quantity
-	Direct unit cost excl. VAT

### Post Document

VAT entry:

Four VAT entries, where is VAT Calculation Type Reverse Charge. First is posted at posting date on document and Postponed VAT is set at Postponed, and type is Sale. Second is posted at VAT output date and Postponed VAT is set at Realized VAT, and type is Sale. Third entry is posted at posting date on document and Postponed VAT is set at Postponed, and type is Purchase. Fourth entry is posted at VAT date and Postponed VAT is set at Realized VAT, and type is Purchase.
