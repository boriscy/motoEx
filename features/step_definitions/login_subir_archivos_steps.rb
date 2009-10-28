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
  fill_in "Contraseña:", :with => "demo123"
  click_button
end

Entonces /^deberia estar logueado$/ do
  response.should render_template("usuarios/show")
end

Entonces /^deberia ir a (.*)$/ do |uri|
  visit(uri)
  fill_in ""
  #attatch_file "", ""
end

Entonces /^debo seleccionar un archivo excel$/ do
  pending
end

