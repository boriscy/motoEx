def crear_usuario
  @usuario = Usuario.create(:nombre => 'admin', :paterno => 'admin', :materno => 'admin', :login => 'admin', :email => 'admin@example.com', :password => 'demo123', :password_confirmation => 'demo123')
end

Dado /^que estoy en (.*)$/ do |uri|
  visit uri
  response.should contain("Usuario:")
  response.should contain("Contraseña:")
end

Cuando /^ingreso mi login y password$/ do
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
  fill_in "Nombre", :with => "Primer Excel"
  fill_in "Descripción", :with => "Contenido de prueba primer Excel"
  attach_file "archivo[archivo_excel]", "#{RAILS_ROOT}/ejemplos/VentasPrecio2000-2008.xls", 'application/vnd.ms-excel'#"/home/boris/www/php-excel-reader/example.xls"
  click_button "Salvar"
end

Entonces /^debo ver el archivo con datos validos$/ do
  response.should render_template("archivos/show")
  @archivo = Archivo.last
  @archivo.lista_hojas.should == ["2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2000_2009"]
  @archivo.hojas.size.should == 1
  File.exists?(File.expand_path(@archivo.archivo_excel.path)).should == true
end

