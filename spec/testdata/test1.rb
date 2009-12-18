@@descartar = {
"desc1"=>{"celdas"=>[{"texto"=>"ABRIL", "id"=>"0_10_1"}, 
  {"texto"=>" ", "id"=>"0_10_2"}, {"texto"=>" ", "id"=>"0_10_3"}, {"texto"=>" ", "id"=>"0_10_4"},
  {"texto"=>"4,894,744.80", "id"=>"0_10_5"}, {"texto"=>"3,019,789.20", "id"=>"0_10_6"}, 
  {"texto"=>"7,914,534.00", "id"=>"0_10_7"}], 
  "patron"=>{"2"=>{"texto"=>" "}},"excepciones"=>[{'pos' => '1', 'texto' => 'MAYO '}],
  "celda_final"=>"10_7", "celda_inicial"=>"10_1"}, 
"desc0"=>{"celdas"=>[{"texto"=>" TOTAL 2000", "id"=>"0_19_1"}, 
  {"texto"=>"693,590.00", "id"=>"0_19_2"}, {"texto"=>"0.00", "id"=>"0_19_3"},
  {"texto"=>"0.00", "id"=>"0_19_4"}, {"texto"=>"75,197,776.90", "id"=>"0_19_5"},
  {"texto"=>"39,042,206.31", "id"=>"0_19_6"}, {"texto"=>"114,933,573.21", "id"=>"0_19_7"}],
  "patron"=>{}, "excepciones"=>[],"celda_final"=>"19_7", "celda_inicial"=>"19_1"}
}

@@hoja_electronica = Excel.new(File.join(File.expand_path(RAILS_ROOT), "ejemplos", "VentasPrecio2000-2008.xls") )
