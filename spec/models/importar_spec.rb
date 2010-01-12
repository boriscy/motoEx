require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Importar do
  before(:each) do
    archivo = File.join(RAILS_ROOT, 'ejemplos/ParteDiario.xls')
    @params = {
      'archivo_tmp' => ActionController::TestUploadedFile.new(archivo, 'application/vnd.ms-excel'),
      'archivo_nombre' => 'c:\\tmp\\ParteDiario.xls',
      'areas' => ["1", "2"]
    }
    @usuario_mock = mock_model(Usuario, :id => 1, :nombre => 'Juan', :valid? => true)
    Usuario.stub!(:find).with(kind_of(Fixnum)).and_return(@usuario_mock)
    @us = Object
    @us.stub!(:record).and_return( @usuario_mock)
    UsuarioSession.stub!(:find).and_return(@us)

  end

  it 'debe crear una instancia' do
    Importar.create!(@params)
  end

  it 'debe asignar correctamente el usuario' do
    @importar = Importar.create(@params)
    @importar.usuario_id.should == 1
  end

  it 'debe convertir en array si se le asigna un Hash a areas' do
    @params['areas'] = {'0' => '1', '2' => '2'}
    @importar = Importar.create!(@params)
    @importar.areas.class.to_s.should == 'Array'
  end

  it 'debe grabar correctamente el nombre del archivo' do
    @importar = Importar.create!(@params)
    @importar.archivo_nombre.should == 'ParteDiario.xls'
  end

  describe "manejo de archivo_tmp" do
    before(:each) do
      Time.stub!(:now).and_return(Time.parse("2010-01-01"))
      @tmp = "#{RAILS_ROOT}/tmp/archivos/#{Time.now.to_i}"
    end

    it 'debe almacenar en tmp/archivos el archivo creado' do
      @importar = Importar.new(@params)
      @importar.archivo_tmp.should == "#{@tmp}#{@importar.archivo_nombre}"
      File.exists?(@importar.archivo_tmp).should == true
      @importar.save
    end

    it 'debe borrar el archivo temporal' do
      @importar = Importar.create(@params)
      File.exists?(@importar.archivo_tmp).should_not == true
    end

    it 'debe almacenar la dimension del archivo' do
      @importar = Importar.create(@params)
      @importar.archivo_size.class.to_s.should == "Fixnum"
    end

  end

  describe "importacion de datos" do
    before(:each) do
      Area.stub!(:find).and_return(:encabezado => {}, :fin => {}, :titular => {}, :sinonimos => {}, :descartar => {})
    end

    it 'debe realizar la importacion de campos' do
      //
    end
  end

end
