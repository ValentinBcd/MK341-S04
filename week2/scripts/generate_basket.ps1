$clients = (Import-Csv -Delimiter ';' ../data/clients.csv | Select-Object client_id)
1..64 |
ForEach-Object {
    $date = (Get-Date).AddDays(-$_).AddMinutes((Get-Random -Minimum 0 -Maximum 2040)).AddSeconds((Get-Random -Minimum 0 -Maximum 60))
    $id = "{0}" -f [guid]::NewGuid()
    $client_id = $clients.client_id[(Get-Random -Minimum 0 -Maximum ($clients.Length-1))]
    "{0};{1};{2}" -f $id, (get-date $date -UFormat "%D %T"), $client_id
} |
ConvertFrom-Csv -Header @('basket_id', 'date', 'client_id') -Delimiter ';' |
Export-Csv ../data/baskets.csv -Delimiter ';' -NoTypeInformation -Encoding utf8