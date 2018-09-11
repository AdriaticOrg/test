codeunit 13063401 "Library Test Help-adl"
{
    Subtype = Normal;

    procedure ToCode20(value: text): text[20];
    begin
        exit(CopyStr(value, 1, 20));
    end;
}