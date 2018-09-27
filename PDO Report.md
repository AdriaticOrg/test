# TEST SCENARIO: PDO Report


## CASE 1

### Enter VAT Posting Setup

- Choose VAT Business Posting Group and VAT Product Posting Group.
- Enter VAT % (informative) for combination.
- Field VAT Calculation Type should be Normal VAT.
- Field VAT % should be 0.
- Enter Sales VAT Account, VAT Identifier.

### Open Sales Invoice

- Choose Customer No.
- Enter VAT Date
- Enter VAT Correction Date on sales documents, which means, for which VAT date transactions, which are corrected with this document, were previously reported (period for correction is calculated from this date). 
- Enter Item on lines.
- Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.

### Post Invoice

### PDO Setup

- Choose PDO Report No. Series 
- Choose Prep. By User ID, Resp. User ID
- Enter PDO VAT Identifier Filter Code

### PDO Report

- No.
- Enter Period Start Date, Period End Date
- Enter Period Year, Period Round
- Choose Prep. By User ID, Resp. User ID
- User suggests PDO entries with functionality Suggest lines based on filters in the header.
- User can manually enter/correct lines in PDO Report.
- User can export PDO entries with functionality Export lines based on filters in the header.

### Error

- You may not enter numbers manually. If you want to enter numbers manualy, please activate Manual Nos. in No. Series VIES.
- Period End Date must have a value in PDO Report Header. It cannot be zero or empty. 
- Status must be equal to 'Open' in PDO Report Header. Current value is 'Realesed'.
- Reporting Name must have a value in User Setup. It cannot be zero or empty.
