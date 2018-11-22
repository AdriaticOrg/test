# TEST SCENARIO: PDO Report


## CASE: Prepare KRT Report

### Assisted Setup

To enable PDO Report functionality you need to set up fields in advanced Adriatic Localization that can be accessed through Assisted Setup.

-	Open Assisted Setup.
-	Choose Set up advanced Adriatic Localization.
-	Program opens wizard.
-	Go to Next page.
-	Choose localization country SI.
-	Enable option PDO enabled.
-	Go to next page.
-	Check or correct data about company.
-	Go to next page.
-	Choose PDO Report No. Series to create PDO reports.
-	Choose PDO Prepared by user ID that will prepare PDO reports when exporting XML file to authorities.
-	Choose PDO Responsible user ID that will be responsible for PDO reports when exporting XML file to authorities.
-	Enter VAT Ident. Filter Code that will be used to filter VAT Entries in PDO Report. 
-	Choose button Finish to confirm setup.

### Enter VAT Posting Setup

-	Choose VAT Business Posting Group and VAT Product Posting Group.
-	Enter VAT % (informative) for combination.
-	Field VAT Calculation Type should be Normal VAT.
-	Field VAT % should be 0.
-	Enter Sales VAT Account, VAT Identifier.

### Post Sales Invoice

-	Choose Customer No.
-	Enter VAT Date
-	Enter VAT Correction Date on sales documents, which means, for which VAT date transactions, which are corrected with this document, were previously reported (period for correction is calculated from this date). 
-	Enter Item on lines.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.
-	Post Invoice.

### PDO Report

-	No.
-	Enter Period Start Date, Period End Date
-	Enter Period Year, Period Round
-	Choose Prep. By User ID, Resp. User ID
-	User suggests PDO entries with functionality Suggest lines based on filters in the header.
-	User can manually enter/correct lines in PDO Report.
-	User can export PDO entries with functionality Export lines based on filters in the header.

### Error:

-	You may not enter numbers manually. If you want to enter numbers manually, please activate Manual Nos. in No. Series VIES.
-	Period End Date must have a value in PDO Report Header. It cannot be zero or empty. 
-	Status must be equal to 'Open' in PDO Report Header. Current value is 'Released'.
-	Reporting Name must have a value in User Setup. It cannot be zero or empty.
