<?php
/**
 * Argumentos
 * $argv[0] Archivo php actual
 * $argv[1] Archivo excel
 * $argv[2] Hoja
 */
include("excel_reader2.php");
$data = new Spreadsheet_Excel_Reader($argv[1]);
$sheets = array();
for($i = 0; $i < count($data->sheets); $i++) {
    $sheets[] = $data->boundsheets[$i]['name'];
}

echo join("|??|", $sheets);
echo "????--||--||--||--||--||--????";
//echo $data->dump(true, true, $argv[2]);
?>
