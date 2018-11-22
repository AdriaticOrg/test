# TEST SCENARIO: Postponed VAT

## CASE 1: VAT date is different than posting date and output VAT date

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

### Post Purchase Document with data:

-	Header:<br>
        Vendor Name: Select vendor from list<br>
        Posting date: Choose posting date. VAT output date is same.<br>
        VAT date: VAT date is different then posting date.<br>
        Postponed VAT: Value is set at Postponed VAT by changing VAT date.<br>
        Vendor Invoice No.: Enter external document No.<br>
-	Line<br>
        Type: G/L Account<br>
        No.: G/L Account No.<br>
        Quantity<br>
        Direct unit cost excl. VAT<br>
-	Post Document<br>

###VAT entry:

-	Two VAT entries where is VAT Calculation Type Reverse Charge. First is posted at posting date on document and Postponed VAT is set at Postponed. Second is posted at VAT date and Postponed VAT is set at Realized VAT.

## CASE 2: VAT date is different than posting date and output VAT date is different than VAT date and posting date.

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

### Post Purchase Document with data:

-	Header:<br>
        Vendor Name: Select vendor from list<br>
        Posting date: Choose posting date.<br>
        VAT date: VAT date is different then posting date.<br>
        VAT output date: Output VAT date is different then VAT date and posting date.<br>
        Postponed VAT: Value is set at Postponed VAT by changing VAT date.<br>
        Vendor Invoice No.: Enter external document No.<br>
-	Line:<br>
        Type: G/L Account<br>
        No.: G/L Account No.<br>
        Quantity<br>
        Direct unit cost excl. VAT<br>
-	Post Document<br>

###VAT entry:

Four VAT entries, where is VAT Calculation Type Reverse Charge. First is posted at posting date on document and Postponed VAT is set at Postponed, and type is Sale. Second is posted at VAT output date and Postponed VAT is set at Realized VAT, and type is Sale. Third entry is posted at posting date on document and Postponed VAT is set at Postponed, and type is Purchase. Fourth entry is posted at VAT date and Postponed VAT is set at Realized VAT, and type is Purchase.
