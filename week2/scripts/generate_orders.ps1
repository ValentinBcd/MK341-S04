$baskets = (Import-Csv -Delimiter ';' ../data/baskets.csv | Select-Object basket_id, date)
$items = (Import-Csv -Delimiter ';' ../data/items.csv | Select-Object basket_id, product_id, units)
$products = (Import-Csv -Delimiter ';' ../data/products.csv | Select-Object product_id, unit_price)
$baskets |
ForEach-Object{
    $b = $_.basket_id
    $bselection = $items | Where-Object basket_id -eq $b | Select-Object product_id, units
    $amount = ($bselection |
    Select-Object @{n='amount'; e={$id = $_.product_id; [float]$_.units*[float]($products | Where-Object product_id -eq $id | Select-Object unit_price).unit_price[0]}} |
    Measure-Object -Property 'amount' -Sum).Sum
    $date = ([DateTime]$_.date).AddMinutes((Get-Random -Minimum 5 -Maximum 50))
    "{0};{1};{2};{3};{4}" -f [guid]::NewGuid(), $date, $b, $amount, (Get-Random -InputObject @('credit card', 'paypal', 'paylib', 'bitcoin'))
} |
ConvertFrom-Csv -Header @('order_id', 'date', 'basket_id', 'amount', 'mode') -Delimiter ';'  |
Export-Csv ../data/orders.csv -Delimiter ';' -NoTypeInformation -Encoding utf8
