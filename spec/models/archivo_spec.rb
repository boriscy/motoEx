require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Archivo do

  it{should belong_to(:usuario)}
  it{should validate_presence_of(:nombre)}


  before(:each) do
   
    archivo = File.join(RAILS_ROOT, 'ejemplos/VentasPrecio2000-2008.xls')
#    up = ActionController::UploadedStringIO.new
#    up.original_path = archivo
#    up.content_type = 'application/vnd.ms-excel'
    @archivo_params = {
      :nombre => 'Excel', 
      :archivo_excel => ActionController::TestUploadedFile.new(archivo, 'application/vnd.ms-excel')
    }
    @usuario_mock = mock_model(Usuario, :id => 1, :nombre => 'Juan', :valid? => true)
    Usuario.stub!(:find).with(kind_of(Fixnum)).and_return(@usuario_mock)
    @us = Object
    @us.stub!(:record).and_return( @usuario_mock)
    UsuarioSession.stub!(:find).and_return(@us)
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

  it "debe poder asignar prelectura" do
    @archivo_params[:prelectura] = 1
    create_archivo()
    @archivo.valid?.should == true
  end

  it "debe asignar fecha_archivo" do
    @archivo = create_archivo()
    @archivo.fecha_modificacion.should_not == nil
  end


  it "debe guardar fecha_modificacion solo con campo (:prelectura)" do
    @archivo = create_archivo()
    fec = @archivo.fecha_modificacion
  
    now = Time.zone.now
    Time.zone.stub!(:now).and_return((now + 10))
    @archivo.update_attribute(:prelectura, true)
    @archivo.fecha_modificacion.to_s.should_not == fec.to_s
  end

  it "debe guardar fecha_modificacion solo con campos (:archivo)" do 
    @archivo = create_archivo()
    fec = @archivo.fecha_modificacion
    archivo = File.join(RAILS_ROOT, 'ejemplos/VentasPrecio2000-2008.xls')
    up = ActionController::UploadedStringIO.new
    up.original_path = archivo
    up.content_type = 'application/vnd.ms-excel'

    now = Time.zone.now + 10.seconds
    Time.zone.stub!(:now).and_return(now)
    # Es necesesario hacer stub a Time.now debido a que no funciona correctamente a Time.zone.now
    Time.stub!(:now).and_return(now)
    @archivo.archivo_excel = up
    @archivo.save
    @archivo.fecha_modificacion.to_s.should_not == fec.to_s
  end

  it "No debe cambiar la fecha para campos que no son (:prelectura o archivo)" do
    @archivo = create_archivo()
    fec = @archivo.fecha_modificacion
    now = Time.zone.now
    Time.zone.stub!(:now).and_return((now + 10))

    @archivo.update_attribute(:nombre, "Prueba de cambio")
    @archivo.fecha_modificacion.to_s.should == fec.to_s
  end

end
