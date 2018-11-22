# TEST SCENARIO: KRD Report


## CASE: Prepare KRD Report

### Assisted Setup

-	Open Assisted Setup.
-	Choose Set up advanced Adriatic Localization.
-	Program opens wizard.
-	Go to Next page.
-	Choose localization country SI.
-	Enable option KRD enabled.
-	Go to next page.
-	Check or correct data about company.
-	Go to next page.
-	Choose KRD Report No. Series to create KRD reports.
-	Choose KRD Responsible user ID that will be responsible for KRD reports when exporting XML file to authorities.
-	Choose KRD Prepared by user ID that will prepare KRD reports when exporting XML file to authorities.
-	Choose Default KRD Affiliation Type that applies to company and will be exported to XML file.
-	Enter KRD Blank LCY Code that will be used for exporting entries that are posted with blank currency. 
-	Enter KRD Blank LCY Num that will be used for exporting entries that are posted with blank currency.
-	Choose button Finish to confirm setup.

### Enter KRD Codes

-	Choose Type: Affiliation Type or Instrument Type or Maturity). 
-	Enter Code, Description.

### Enter KRD Finance Instruments

-	Enter Code, Description.
-	Choose Type (Posting or Total). User sets Posting on FAS Sectors that entries can be posted on.

### Edit Customer/Vendor Posting Groups

-	Choose appropriate KRD Claim/Liability.
-	Choose appropriate KRD Instrument Type.
-	Choose appropriate KRD Maturity.

### Edit Customer/Vendor Card 

-	Choose appropriate KRD Non-Resident Sector Code for the customer/vendor. 
-	Choose appropriate KRD Affiliation Type for the customer/vendor.

### Post Sales/Purchase Invoice

-	Create Sales/Purchase Invoice with all mandatory fields for posting.
-	Post Invoice.

### Adjust KRD on Entries

-	User adjust G/L entries with functionality Adjust KRD on Entries based on filters in the header.

### KRD Report

-	No.
-	Enter Period Start Date, Period End Date
-	Choose Prep. By User ID, Resp. User ID
-	Previous Report No.
-	User suggests KRD entries with functionality Suggest lines based on filters in the header.
-	User can manually enter/correct lines in KRD Report.
-	User can export KRD entries with functionality Export lines based on filters in the header.

### Error:

-	You may not enter numbers manually. If you want to enter numbers manually, please activate Manual Nos. in No. Series KRD.
-	Period End Date must have a value in KRD Report Header. It cannot be zero or empty. 
-	Status must be equal to 'Open' in KRD Report Header. Current value is 'Released'.
-	Reporting Name must have a value in User Setup. It cannot be zero or empty.
