# TEST SCENARIO: Full VAT Posting

## CASE

### Create VAT posting setup:

-	VAT Bus. Posting Group: enter VAT Bus. Posting Group (A).
-	VAT Prod. Posting Group: enter VAT Prod. Posting Group (A).
-	VAT Calculation Type: choose Full VAT.
-	VAT %: Enter percentage.
-	VAT % (retrograde): Enter percentage.
-	Purchase VAT Account: Set account for posting.

### Create new G/L Account:

-	Choose Gen. Prod. Posting Group
-	Choose VAT Prod. Posting Group (A)

### Create Purchase Document with following data:

#### Header

-	Vendor Name: Select vendor from list
-	Posting date: Choose posting date. 
-	Vendor Invoice No.: Enter External Document No.

#### Line

-	Choose Type: G/L Account
-	Enter No. G/L Account No.
-	Enter Quantity.
-	Enter Direct unit cost excl. VAT

### Post Document

### Check VAT entry:

-	One VAT entry where is VAT Calculation Type Full VAT. 
-	Base is zero, Amount is full amount from document, and VAT Base (Retro.) is calculated by formula Amount*100/ VAT % (retrograde).
