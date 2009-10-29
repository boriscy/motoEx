require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Archivo do

  it{should belong_to(:usuario)}
  it{should validate_presence_of(:nombre)}

  before(:each) do
    @archivo_params = {
      :nombre => 'Excel', 
  #    :archivo_excel_file_nane => RAILS_ROOT + '/ejemplos/VentasPrecio2000-2008.xls',
      :archivo_excel => RAILS_ROOT + '/ejemplos/VentasPrecio2000-2008.xls'
    }
    @usuario_mock = mock_model(Usuario, :id => 1, :nombre => 'Juan')
    Usuario.stub!(:find).with(kind_of(Fixnum)).and_return(@usuario_mock)
    @us = mock("record", :record => @usuario_mock)
    UsuarioSession.stub!(:find).and_return(@us)
    #Paperclip::Attachment.stubs(:validates_attachment_presence).returns(true)
    Archivo.any_instance.stubs(:archivo_excel).returns({})
  end

  def create_archivo
    @archivo = Archivo.create(@archivo_params)
  end

  def stub_especial(klass)
  end

  it "debe crear" do
    Archivo.create!(@archivo_params)
  end

  it "debe guardar el usuario" do
    create_archivo()
    @archivo.usuario.id.should == 1
  end

end
