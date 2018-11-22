# TEST SCENARIO: Full VAT Posting

## CASE: Post Full VAT on Purchase Invoice

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

### Post Purchase Document with following data:

-	Header:<br>
        Vendor Name: Select vendor from list<br>
        Posting date: Choose posting date. <br>
        Vendor Invoice No.: Enter External Document No.<br>
-	Line:<br>
        Choose Type: G/L Account<br>
        Enter No. G/L Account No.<br>
        Enter Quantity.<br>
        Enter Direct unit cost excl. VAT<br>
-	Post Document<br>

### Check VAT entry:

-	One VAT entry where is VAT Calculation Type Full VAT. 
-	Base is zero, Amount is full amount from document, and VAT Base (Retro.) is calculated by formula Amount*100/ VAT % (retrograde).
