Dado /^que me logueo$/ do
  crear_usuario()
  #
  visit "/"
  fill_in "usuario_session[login]", :with => "admin"
  fill_in "Contraseña", :with => "demo123"
  click_button "Ingresar"
end

Y /^que tengo el archivo "([^\"]*)"$/ do |archivo|
  # Se llma a la funcion en: spec/factories/all_factory.rb
  Soporte::crear_archivo_test(archivo)
  hoja_electronica = Excel.new(File.join(RAILS_ROOT, "ejemplos", archivo))

  area = Area.last
  @area_general = AreaGeneral.new(area, hoja_electronica)
end

Entonces /^debo poder leer los datos seleccionados de este archivo$/ do
  @resp = @area_general.leer()
  @resp.size.should == 8
end

