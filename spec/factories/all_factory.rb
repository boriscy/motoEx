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
