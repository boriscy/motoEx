Factory.define :usuario do |u|
  u.nombre ""
  u.paterno "" 
  u.materno ""
  u.login
  u.password
  u.password_confirmation
  u.rol_id
  u.grupo_ids 
end

def crear_archivos
  Dir.glob( File.join(RAILS_ROOT, "ejemplos/*.xls") ).each_with_index do |a, i|
    params = {
      :nombre => "Archivo #{i + 1}", 
      :descripcion => "Prueba #{i + 1}",
      :archivo_excel => ActionController::TestUploadedFile.new(a, 'application/vnd.ms-excel')
    }
    Archivo.create!(params)
  end
end

def crear_archivo_hojas(archivo_excel)
  archivo = Archivo.find_by_archivo_excel_file_name(archivo_excel)
  (Excel.new(archivo.archivo_excel.path) ).sheets.each_with_index do |h, i|
    archivo.hojas << Hoja.new(:numero => i, :nombre => h)
  end
end

def crear_areas(hoja)
  area = { :id => 1, :hoja_id => 10, 
  :nombre => "Mi salvada", :celda_inicial => "3_1", 
  :celda_final => "19_7", :rango => 5, :fija => false, 
  :iterar_fila => true, 
  :encabezado => 
    {"celdas"=>[{"texto"=>"DESTINO", "pos"=>"5_1"}, {
    "texto"=>"ARGENTINA", "pos"=>"5_2"}, 
    {"texto"=>"BG COMGAS", "pos"=>"5_3"}, 
    {"texto"=>"CUIABA", "pos"=>"5_4"}, 
    {"texto"=>"GSA", "pos"=>"5_5"}, 
    {"texto"=>"MERCADO \nINTERNO", "pos"=>"5_6"}, 
    {"texto"=>"TOTAL GN", "pos"=>"5_7"}, 
    {"texto"=>"(EN MMBTU)", "pos"=>"6_2"}],
    "campos"=>{"5_5"=>{"campo"=>"gsa", "texto"=>"GSA"},
    "5_1"=>{"campo"=>"destino", "texto"=>"DESTINO"},
    "5_3"=>{"campo"=>"bg", "texto"=>"BG COMGAS"}},
    "celda_final"=>"6_7", "celda_inicial"=>"5_1"},
    :fin => {"celdas"=>
    [{"texto"=>"TOTAL 2000", "pos"=>"0_19_1"},
      {"texto"=>"693,590.00", "pos"=>"0_19_2"}, 
      {"texto"=>"0.00", "pos"=>"0_19_3"},
      {"texto"=>"0.00", "pos"=>"0_19_4"},
      {"texto"=>"75,197,776.90", "pos"=>"0_19_5"},
      {"texto"=>"39,042,206.31", "pos"=>"0_19_6"},
      {"texto"=>"114,933,573.21", "pos"=>"0_19_7"}
    ], "campos"=>{"0_19_1"=>{"campo"=>"TOTAL 2000","texto"=>"TOTAL 2000"}}, 
    "celda_final"=>"19_7",
    "celda_inicial"=>"19_1"},
    :descartar => {"desc0"=>{"excepciones"=>[], "patron"=>{"2"=>{"texto"=>""}}, 
    "celda_final"=>"10_7", "celda_inicial"=>"10_1"}},
    :created_at => "2009-12-22 14:23:09", 
    :updated_at => "2009-12-22 14:23:09", 
    :titular => {"celdas"=>[{"texto"=>"VENTAS DE GAS NATURAL\nGESTIÓN 2000", "pos"=>"3_1"}], 
    "celda_final"=>"3_7", "celda_inicial"=>"3_1"}
}
  area[:hoja_id] = hoja.id
  Area.create(area)
end
