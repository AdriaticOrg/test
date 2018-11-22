# TEST SCENARIO: FAS Report

## CASE: Prepare FAS Report

### Assisted Setup

-	Open Assisted Setup.
-	Choose Set up advanced Adriatic Localization.
-	Program opens wizard.
-	Go to Next page.
-	Choose localization country SI.
-	Enable option FAS enabled.
-	Go to next page.
-	Check or correct data about company.
-	Go to next page.
-	Choose FAS Report No. Series to create FAS reports.
-	Choose FAS Responsible user ID that will be responsible for FAS reports when exporting XML file to authorities.
-	Choose FAS Prepared by user ID that will prepare FAS reports when exporting XML file to authorities.
-	Choose FAS Director by user ID that will prepare FAS reports when exporting XML file to authorities.
-	Enter Budget User Code that will be exported to XML file.
-	Enter Company Sector Code of company that will be exported to XML file.
-	Choose button Finish to confirm setup.

### Enter FAS Finance Sectors

-	Enter Code, Description.
-	Choose Type (Posting or Total). User sets Posting on FAS Sectors that entries can be posted on.
-	User sets Totaling on FAS Sectors with Type equal Total.

### Enter FAS Finance Instruments

-	Enter Code, Description.
-	Choose Type (Posting or Total). User sets Posting on FAS Sectors that entries can be posted on.
-	Enter AOP Code.

### Edit G/L Account Card 

-	Set check mark in FAS Account, if entries need to be reported in FAS Report.
-	Choose FAS Type (Assets or Liabilities). 
-	Choose appropriate FAS Sector Code. Leave field empty in case the sector that should be applied is set on customer/vendor card.
-	Choose appropriate FAS Instrument Code. 

### Edit Customer/Vendor Card 

-	Choose appropriate FAS Sector Code for the customer/vendor. 

### Post Sales/Purchase Invoice

-	Create Sales/Purchase Invoice with all mandatory fields for posting.
-	Choose G/L Account that has FAS Instrument Code entered on G/L Account Card.
-	Post Invoice.

### Adjust FAS on Entries

-	User adjust G/L entries with functionality Adjust FAS on Entries based on filters in the header.

### FAS Report

-	No.
-	Enter Period Start Date, Period End Date
-	Enter Period Year, Period Round
-	Choose Prep. By User ID, Resp. User ID
-	Enter Previous Report No.
-	User suggests FAS entries with functionality Suggest lines based on filters in the header.
-	User can manually enter/correct lines in FAS Report.
-	User can export FAS entries with functionality Export lines based on filters in the header.

### Error:

-	You may not enter numbers manually. If you want to enter numbers manually, please activate Manual Nos. in No. Series FAS.
-	Period End Date must have a value in FAS Report Header. It cannot be zero or empty. 
-	Status must be equal to 'Open' in FAS Report Header. Current value is 'Released'.
-	Reporting Name must have a value in User Setup. It cannot be zero or empty.
