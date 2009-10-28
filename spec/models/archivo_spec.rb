require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Archivo do

  it{should belong_to(:usuario)}
  it{should validate_presence_of(:nombre)}
  it{should validate_presence_of(:archivo_html)}
  it{should validate_presence_of(:archivo_excel)}

  before(:each) do
    @archivo_params = {:nombre => 'Excel', :archivo_excel => 'uno.xls', :archivo_html => 'uno.html'}
    @usuario_mock = mock_model(Usuario, :id => 1, :nombre => 'Juan')
    Usuario.stub!(:find).with(kind_of(Fixnum)).and_return(@usuario_mock)
    @us = mock("record", :record => @usuario_mock)
    UsuarioSession.stub!(:find).and_return(@us)
  end

  def create_archivo
    @archivo = Archivo.create(@archivo_params)
  end

  it "debe crear" do
    Archivo.create!(@archivo_params)
  end

  it "validar .xls" do
    @archivo_params[:archivo_excel] = 'esto.xlx'
    @archivo = Archivo.create(@archivo_params)
    @archivo.errors[:archivo_excel].should_not == nil
  end

  it "validar .html" do
    @archivo_params[:archivo_html] = 'esto.htms'
    @archivo = Archivo.create(@archivo_params)
    @archivo.errors[:archivo_html].should_not == nil
  end

  it "debe guardar el usuario" do
    create_archivo()
    @archivo.usuario.id.should == 1
  end

end
