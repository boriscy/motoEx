# Dado /^que me logueo$/ do # Se encuentar en

Y /^que subo el archivo "([^\"]*)"$/ do |archivo|
  # Se llma a la funcion en: spec/factories/all_factory.rb
  Soporte::crear_archivo_test(archivo)
  hoja_electronica = Excel.new(File.join(RAILS_ROOT, "ejemplos", archivo))

  area = Area.last
  @area_general = AreaGeneral.new(area, hoja_electronica)
end

