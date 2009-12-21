def crear_usuario
  @usuario = Usuario.create(:nombre => 'admin', :paterno => 'admin', :materno => 'admin', :login => 'admin', :email => 'admin@example.com', :password => 'demo123', :password_confirmation => 'demo123')
end

Dado /^que me logueo y tengo los datos$/ do
  crear_usuario()
  #
  visit "/"
  fill_in "usuario_session[login]", :with => "admin"
  fill_in "Contraseña", :with => "demo123"
  click_button "Ingresar"
  # Creacion de archivos
  crear_archivos()
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
  crear_archivo_hojas(link)
  click_link(link)
end

Y /^debo seleccionar la hoja (.*)$/ do |hoja|
  select(hoja)
end


