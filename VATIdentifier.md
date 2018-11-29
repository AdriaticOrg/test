# TEST SCENARIO: VAT Identifier

## Setup

### Enter VAT Identifiers

-	Enter Code and Description for VAT Identifier.

    Code|Description
    ----|-----------
    12|D-DA + B-22 - ODB (8,18)
    14|K-DA + B-22 - OBR (7,14)

### Enter VAT Posting Setup

-	Choose VAT Business Posting Group and VAT Product Posting Group.
-	Enter VAT Identifier for combination. 

    VAT Bus. Posting Group|VAT Prod. Posting Group|VAT Identifier
    ----------------------|-----------------------|--------------
    D-DA|B-22|12
    K-DA|B-22|14

## CASE 1: VAT Identifier on VAT Entries for Sales Invoice

### Post Sales Invoice

-	Choose Customer No.
-	Enter all mandatory data for posting Sales Invoice such as Posting Date, Document Date.
-	Enter Item, Quantity and Unit Price on lines.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.

    VAT Bus. Posting Group|VAT Prod. Posting Group
    ----------------------|-----------------------
    K-DA|B-22

-	Post Invoice
-	Check VAT Entries for Posted Sales Invoice

    VAT Bus. Posting Group|VAT Prod. Posting Group|VAT Identifier
    ----------------------|-----------------------|--------------
    K-DA|B-22|14

## Test case acceptance criteria

-	VAT Identifier is transferred VAT Entry for Posted Sales Invoice

## CASE 2: VAT Identifier on VAT Entries for Sales Credit Memo

### Post Credit Memo

-	Choose Customer No.
-	Enter all mandatory data for posting Sales Credit Memo such as Posting Date, Document Date.
-	Enter Item, Quantity and Unit Price on lines.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.

    VAT Bus. Posting Group|VAT Prod. Posting Group
    ----------------------|-----------------------
    K-DA|B-22

-	Post Invoice
-	Check VAT Entries for Posted Sales Invoice

    VAT Bus. Posting Group|VAT Prod. Posting Group|VAT Identifier
    ----------------------|-----------------------|--------------
    K-DA|B-22|14

## Test case acceptance criteria

-	VAT Identifier is transferred VAT Entry for Posted Sales Credit Memo

## CASE 3: VAT Identifier on VAT Entries for Purchase Invoice

### Post Purchase Invoice

-	Choose Vendor No.
-	Enter all mandatory data for posting Purchase Invoice such as Posting Date, Document Date.
-	Enter Item, Quantity and Direct Unit Cost on lines.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.

    VAT Bus. Posting Group|VAT Prod. Posting Group
    ----------------------|-----------------------
    D-DA|B-22

-	Post Invoice
-	Check VAT Entries for Posted Purchase Invoice

    VAT Bus. Posting Group|VAT Prod. Posting Group|VAT Identifier|Type
    ----------------------|-----------------------|--------------|----
    D-DA|B-22|12|Purchase

## Test case acceptance criteria

-	VAT Identifier is transferred VAT Entry for Posted Purchase Invoice

## CASE 4: VAT Identifier on VAT Entries for Purchase Credit Memo

### Post Purchase Credit Memo

-	Choose Vendor No.
-	Enter all mandatory data for posting Purchase Credit Memo such as Posting Date, Document Date.
-	Enter Item, Quantity and Direct Unit Cost on lines.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.

    VAT Bus. Posting Group|VAT Prod. Posting Group
    ----------------------|-----------------------
    D-DA|B-22

-	Post Invoice
-	Check VAT Entries for Posted Purchase Credit Memo

    VAT Bus. Posting Group|VAT Prod. Posting Group|VAT Identifier|Type
    ----------------------|-----------------------|--------------|----
    D-DA|B-22|12|Purchase

## Test case acceptance criteria

-	VAT Identifier is transferred VAT Entry for Posted Purchase Invoice

## CASE 5: VAT Identifier on VAT Entries for journals when Posting on Sale Type

### Post General Journal

-	Choose G/L Account No.
-	Enter all mandatory data for posting Journal such as Posting Date, Document Number, Amount, Balance Account Type and Balance Account No.
-	Choose General Posting Type, General Product Posting Group and General Business Posting Group.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.

    Account Type|Account No.|Gen. Posting Type|General Bus. Posting Group|General Prod. Posting Group|VAT Bus. Posting Group|VAT Prod. Posting Group|Amount|Bal. Account Type|Bal. Account No.
    ------------|-----------|-----------------|--------------------------|---------------------------|----------------------|-----------------------|------|-----------------|----------------
    G/L Account|760010|Sale|D-DA|B-SPL|D-DA|B-22|100,00|Customer|Customer No.

-	Post Journal
-	Check VAT Entries for Journal

    VAT Bus. Posting Group|VAT Prod. Posting Group|VAT Identifier|Type
    ----------------------|-----------------------|--------------|----
    K-DA|B-22|14|Sale

## Test case acceptance criteria

-	VAT Identifier is transferred VAT Entry for Posted Journal

## CASE 6: VAT Identifier on VAT Entries for journals when Posting on Purchase Type

### Post General Journal

-	Choose G/L Account No.
-	Enter all mandatory data for posting Journal such as Posting Date, Document Number, Amount, Balance Account Type, Balance Account No. and External Document No.
-	Choose General Posting Type, General Product Posting Group and General Business Posting Group.
-	Choose VAT Product Posting Group and VAT Business Posting Group that was previously created.

    Account Type|Account No.|Gen. Posting Type|General Bus. Posting Group|General Prod. Posting Group|VAT Bus. Posting Group|VAT Prod. Posting Group|Amount|Bal. Account Type|Bal. Account No.
    ------------|-----------|-----------------|--------------------------|---------------------------|----------------------|-----------------------|------|-----------------|----------------
    G/L Account|415010|Purchase|D-DA|B-SPL|D-DA|B-22|100,00|Vendor|Vendor No.

-	Post Journal
-	Check VAT Entries for Journal

    VAT Bus. Posting Group|VAT Prod. Posting Group|VAT Identifier|Type
    ----------------------|-----------------------|--------------|----
    D-DA|B-22|12|Purchase

## Test case acceptance criteria

-	VAT Identifier is transferred VAT Entry for Posted Journal