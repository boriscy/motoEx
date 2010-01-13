# Dado /^que me logueo$/ do # Se encuentar en

Y /^que subo el archivo "([^\"]*)"$/ do |archivo|
  # Se llma a la funcion en: spec/factories/all_factory.rb
  Soporte::crear_archivo_test(archivo)
  #hoja_electronica = Excel.new(File.join(RAILS_ROOT, "ejemplos", archivo))
  @archivo = archivo
  area = Area.last
  archivo_tmp = File.join(RAILS_ROOT, 'ejemplos', archivo)
  @archivo_tmp = ActionController::TestUploadedFile.new(archivo_tmp, 'application/vnd.ms-excel')
 
  post '/importar.json', {'importar' => {'archivo_tmp' => @archivo_tmp, 'archivo_nombre' => archivo,
  'areas[0]' => area.id}, 'login' => 'admin', 'password' => 'demo123'}
end

Entonces /^debo importar los datos$/ do
  archivo = @archivo.gsub(File.extname(@archivo), "") + "Resp.csv"
  f = File.open(File.join(RAILS_ROOT, 'ejemplos', 'areas', archivo))
  resp = ActiveSupport::JSON.decode(response.body)
  resp[resp.keys.first].to_csv_hash.should == f.inject(""){|t, v| t << v }
end
