# CASE 1

### Enter Sales & Rec. Setup:
- Extended Data Start Balance Date: enter date

### Enter Journal with data: 

- Posting Date: before Extended Data Start Balance Date entered in Sales & Rec. Setup
- Account Type: Customer
- Account No.: Customer No
- Due Date: after Posting Date
- Document No.
- Debit Amount
- Balance Account Type: G/L Account
- Balance Account No.: G/L Account No.
- Open Amount (LCY) Without Unrealized Exch. Rate Adj
- Original Document Amount (LCY)
- Original Amount (LCY)

### Post Journal

### Check Customer Ledger Entry if fields are filled:

- Open Amount (LCY) Without Unrealized Exch. Rate Adj
- Original Document Amount (LCY)
- Original Amount (LCY)

### Run report: Overdue and Uncoll.Rec-adl (13062741):

- Until Due Date: enter date after Due Date
- Choose User

### Error:

- Customer Ledger Entry doesn't have entered amounts in additional fields in ext. Table 21 so entries can't be printed.

# CASE 2

### Enter Sales & Rec. Setup:

- Extended Data Start Balance Date: enter date

### Enter Journal with data: 

- Posting Date: after Extended Data Start Balance Date entered in Sales & Rec. Setup
- Account Type: Customer
- Account No.: Customer No
- Due Date: after Posting Date
- Document No.
- Debit Amount
- Balance Account Type: G/L Account
- Balance Account No.: G/L Account No.
- Open Amount (LCY) Without Unrealized Exch. Rate Adj
- Original Document Amount (LCY)
- Original Amount (LCY)

### Post Journal

### Check Customer Ledger Entry if fields are filled:

- Open Amount (LCY) Without Unrealized Exch. Rate Adj
- Original Document Amount (LCY)
- Original Amount (LCY)

### Run report: Overdue and Uncoll.Rec-adl (13062741):

- Until Due Date: enter date after Due Date
- Choose User

### Error:

- Customer Ledger Entry doesn't have entered amounts in additional fields in ext. Table 21 so entries can't be printed.

# CASE 3

### Enter Sales & Rec. Setup:

- Extended Data Start Balance Date: enter date

### Enter Sales Invoice with data: 

- Posting Date: after Extended Data Start Balance Date entered in Sales & Rec. Setup
- Customer No.
- Due Date: after Posting Date
- Enter line for Item, Qty and Unit Price Excl. VAT

### Post Invoice

### Run report: Overdue and Uncoll.Rec-adl (13062741)

- Until Due Date: enter date after Due Date
- Choose User

### Error:

- Fields can't be printed from posted document.
