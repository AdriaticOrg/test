# TEST SCENARIO: FAS Report


## CASE 1

### Enter FAS Finance Sectors

- Enter Code, Description.
- Choose Type (Posting or Total). User sets Posting on FAS Sectors that entries can be posted on.
- User sets Totaling on FAS Sectors with Type equal Total.

### Enter FAS Finance Instruments

- Enter Code, Description.
- Choose Type (Posting or Total). User sets Posting on FAS Sectors that entries can be posted on.
- Enter AOP Code.

### Edit G/L Account Card 

- Set chack mark in FAS Account, if entries need to be reported in FAS Report.
- Choose FAS Type (Assets or Liabilities). 
- Choose appropriate FAS Sector Code. Leave field empty in case the sector that should be applied is set on customer/vendor card.
- Choose appropriate FAS Instrument Code. 

### Edit Customer/Vendor Card 

- Choose appropriate FAS Sector Code for the customer/vendor. 

### Post Invoice

### FAS Setup

- Choose FAS Report No. Series 
- Choose Prep. By User ID, Resp. User ID
- Enter Budget User Code (or 00000)
- Choose appropriate Company Sector Code.

### Adjust FAS on Entries

- User adjust G/L entries with functionality Adjust FAS on Entries based on filters in the header.

### FAS Report

- No.
- Enter Period Start Date, Period End Date
- Enter Period Year, Period Round
- Choose Prep. By User ID, Resp. User ID
- Enter Previous Report No.
- User suggests FAS entries with functionality Suggest lines based on filters in the header.
- User can manually enter/correct lines in FAS Report.
- User can export FAS entries with functionality Export lines based on filters in the header.

### Error

- You may not enter numbers manually. If you want to enter numbers manualy, please activate Manual Nos. in No. Series FAS.
- Period End Date must have a value in FAS Report Header. It cannot be zero or empty. 
- Status must be equal to 'Open' in FAS Report Header. Current value is 'Realesed'.
- Reporting Name must have a value in User Setup. It cannot be zero or empty.
