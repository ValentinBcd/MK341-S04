$baskets = (Import-Csv -Delimiter ';' ../data/baskets.csv | Select-Object basket_id)
$products = (import-csv -Delimiter ';' ../data/products.csv | Select-Object product_id)

$baskets | 
ForEach-Object {
    $basket_id = $_.basket_id
    $size = Get-Random -Minimum 1 -Maximum 7
    $choice = Get-Random -InputObject $products -Count $size
    $choice |
    ForEach-Object {
        $product_id = $_.product_id
        $units = Get-Random -Minimum 1 -Maximum 3
        "{0};{1};{2};{3}" -f [guid]::NewGuid(), $basket_id, $product_id, $units
    }
} |
ConvertFrom-Csv -Header @('selection_id', 'basket_id', 'product_id', 'units') -Delimiter ';' |
Export-Csv ../data/items.csv -Delimiter ';' -NoTypeInformation -Encoding utf8

