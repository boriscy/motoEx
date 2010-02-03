Dado /^que me logueo para importar$/ do |table|
  Soporte::crear_usuario()

  @tabla = table.hashes
  visit "/"
  fill_in "usuario_session[login]", :with => "admin"
  fill_in "Contraseña", :with => "demo123"
  click_button "Ingresar"
  # Creacion de archivos
  @tabla.each do |hash|
    Soporte::crear_archivo_test(hash['yaml'])
  end
end

Y /^visito (.*)$/ do |uri|
  visit uri
  # Verifico que hayan sido creados
  response.should have_tag("tr") do |tr|
    Dir.glob( File.join(RAILS_ROOT, "ejemplos/*.xls") ).each_with_index do |a, i|
      tr.should have_tag("td", :text => "Archivo #{i + 1}")
      tr.should have_tag("a", :text => File.basename(a))
    end
  end
end

Entonces /^hago click en (.*)$/ do |link|
  @archivo_nombre = link
  crear_archivo_hojas(link)
  click_link(link)
end

Y /^debo seleccionar la hoja (.*)$/ do |hoja|
  select(hoja)
  @hoja_nombre = hoja
end

Cuando /^voy a importar$/ do
  archivo = Archivo.find_by_archivo_excel_file_name(@archivo_nombre)
  @hoja = archivo.hojas.find_by_nombre(@hoja_nombre)
  # Creacion de areas
  crear_areas(@hoja)

  get "/importar/#{@hoja.id}.json"
end

Entonces /^debo ver el listado$/ do
  response.should have_text(@hoja.areas.all(:select => "id, nombre").to_json )
end

Y /^selecciono la "([^\"]*)" y mi archivo "([^\"]*)"$/ do |arg1, arg2|
  archivo = File.join(RAILS_ROOT, "ejemplos", @archivo_nombre)
  post "/importar", :importar => { :areas => ["1", "2"], :archivo_tmp => archivo}
end

