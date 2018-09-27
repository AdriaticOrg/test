# TEST SCENARIO: VIES Report


## CASE 1

### Enter VAT Posting Setup

-	Choose VAT Business Posting Group and VAT Product Posting Group.
-	Enter VAT %, VIES Goods and EU Service for combination.
-	Field VAT Calculation Type should be Normal VAT.
-	Enter Sales VAT Account.

### Open Sales Invoice

-	Choose Customer No.
-	Enter VAT Date
-	Enter VAT Correction Date on sales documents, which means, for which VAT date transactions, which are corrected with this document, were previously reported (period for correction is calculated from this date). 
-	Enter Item on lines.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.
-	Invoice Details: set a check mark in EU 3-Party Trade if transactions from the document need to be reported in VIES as 3-Party Trade.  
-	Invoice Details: set a check mark in EU Customes Procedure, if transactions from document need to be reported in VIES as transactions from special customs procedures.

### Post Invoice

### VIES Setup

-	Choose Default VIES Country
-	Choose Default VIES Type, if Default VIES Country is Croatia
-	Enter VIES Company Branch Code (or 00000)
-	Choose VIES Report No. Series 
-	Choose Prep. By User ID, Resp. User ID

### VIES Report

-	No.
-	Choose VIES Country
-	Choose VIES Type, if Default VIES Country is Croatia
-	Enter Period Start Date, Period End Date
-	Enter Period Year, Period Round
-	Choose Prep. By User ID, Resp. User ID
-	User suggests VIES entries with functionality Suggest lines based on filters in the header.
-	User can manually enter/correct lines in VIES Report.
-	User export VIES entries with functionality Export lines based on filters in the header.
-	User can Export VIES Report in format based on VIES Country. 

### Error

-	You may not enter numbers manually. If you want to enter numbers manualy, please activate Manual Nos. in No. Series VIES.
-	VIES Country must not be enter in VIES Report.
-	Period End Date must have a value in VIES Report Header. It cannot be zero or empty. 
-	Status must be equal to 'Open' in VIES Report Header. Current value is 'Realesed'.
-	Reporting Name must have a value in User Setup. It cannot be zero or empty.
