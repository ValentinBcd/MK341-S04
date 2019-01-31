1..100 |
ForEach-Object {
    "P{0:D5};description of the product {0};{1};{2}" -f $_, 1000, (Get-Random -Minimum 5 -Maximum 79)
} |
ConvertFrom-Csv -Header @('product_id', 'description', 'units', 'unit_price') -Delimiter ';'  |
Export-Csv ../data/products.csv -Delimiter ';' -NoTypeInformation -Encoding utf8