1..50 |
ForEach-Object {
    "{0};{0}-first-name;{0}-last-name;country{1:D2};{0}-email;{4}-{3:D2}-{2:D2}" -f [guid]::NewGuid(),
    (Get-Random -Minimum 0 -Maximum 10),
    (Get-Random -Minimum 1 -Maximum 28),
    (Get-Random -Minimum 1 -Maximum 12),
    (Get-Random -Minimum 1970 -Maximum 2001)
} |
ConvertFrom-Csv -Header @('client_id', 'first_name', 'last_name', 'country', 'email', 'birth_date') -Delimiter ';' |
Export-Csv ../data/clients.csv -Delimiter ';' -NoTypeInformation -Encoding utf8