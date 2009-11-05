require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Archivo do

  it{should belong_to(:usuario)}
  it{should validate_presence_of(:nombre)}

  def mock_uploader(file, type = 'image/png')
    filename = "%s/%s" % [ File.dirname(__FILE__), file ]
    uploader = ActionController::UploadedStringIO.new
    uploader.original_path = filename
    uploader.content_type = type
    def uploader.read
      File.read(original_path)
    end
    def uploader.size
      File.stat(original_path).size
    end
    uploader
  end

  before(:each) do
   
    archivo = File.join(RAILS_ROOT, 'ejemplos/VentasPrecio2000-2008.xls')
    up = ActionController::UploadedStringIO.new
    up.original_path = archivo
    up.content_type = 'application/vnd.ms-excel'
    @archivo_params = {
      :nombre => 'Excel', 
      :archivo_excel => up
    }
    @usuario_mock = mock_model(Usuario, :id => 1, :nombre => 'Juan', :valid? => true)
    Usuario.stub!(:find).with(kind_of(Fixnum)).and_return(@usuario_mock)
    @us = mock("record", :record => @usuario_mock)
    UsuarioSession.stub!(:find).and_return(@us)
    #Paperclip::Attachment.stubs(:validates_attachment_presence).returns(true)
#    Archivo.stubs(:validates_attachment_presence).returns(true)
#    Archivo.stubs(:validates_attachment_content_type).returns(true)
#    Archivo.any_instance.stubs(:save_attached_files).returns(true)
#    Archivo.any_instance.stubs(:destroy_attached_files).returns(true)
    #Paperclip::Attachment.any_instance.stubs(:post_process).returns(true)
  end

  def create_archivo
    @archivo = Archivo.create(@archivo_params)
  end

  it "debe crear" do
    a = Archivo.create!(@archivo_params)
  end

  it "debe guardar el usuario" do
    create_archivo()
    @archivo.usuario.id.should == 1
  end

  it "debe serializar lista_hojas" do
    create_archivo()
    @archivo.asignar_lista_hojas( ["Primera", "Alma", "Estereotipo"] )
    @archivo.save

    a = Archivo.last
    a.lista_hojas[0].should == "Primera"
    a.lista_hojas[2].should == "Estereotipo"
  end

  it "debe poder asignar prelectura" do
    @archivo_params[:prelectura] = 1
    create_archivo()
    @archivo.valid?.should == true
  end

end
