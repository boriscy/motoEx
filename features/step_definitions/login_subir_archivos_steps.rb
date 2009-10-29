def crear_usuario
  @usuario = Usuario.create(:nombre => 'admin', :paterno => 'admin', :materno => 'admin', :login => 'admin', :email => 'admin@example.com', :password => 'demo123', :password_confirmation => 'demo123')
end

Dado /^que estoy en (.*)$/ do |uri|
  visit uri
  response.should contain("Usuario:")
  response.should contain("Contraseña:")
end

Entonces /^ingreso mi login y password$/ do
  crear_usuario()
  fill_in "usuario_session[login]", :with => "admin"
  #fill_in "usuario_session[password]", :with => "demo123"
  fill_in "Contraseña", :with => "demo123"
  click_button "Ingresar"
end

Entonces /^deberia estar logueado$/ do
  response.should render_template("usuarios/show")
  flash[:notice].should =~ /[a-z]+/i
end


Y /^deberia ir a (.*)$/ do |uri|
  visit(uri)
  stubs_archivo()
  fill_in "Nombre", :with => "Primer Excel"
  fill_in "Descripción", :with => "Contenido de prueba primer Excel"
  attach_file "archivo[archivo_excel]", "#{RAILS_ROOT}/ejemplos/VentasPrecio2000-2008.xls" #"/home/boris/www/php-excel-reader/example.xls"
  click_button "Salvar"
end

Entonces /^debo ver el archivo$/ do
  response.should render_template("archivos/show")
end

Y /^deberia haberse creado un html de la primera hoja$/ do
  pending
end

#########
def stubs_archivo()
  Archivo.any_instance.stubs(:valid?).returns(true)
end
