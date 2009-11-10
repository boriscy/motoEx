require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hoja do

  def mock_archivo
    @archivo = "ejemplos/example.xls"
    Archivo.any_instance.stubs(:valid?).returns(true)
    Archivo.any_instance.stubs(:update_attribute).with(:lista_hojas, kind_of(Array))
    @path = mock("path", :path => @archivo)
    @archivo_mock = mock_model(Archivo, :id => 1, :archivo_excel_file_name => File.basename(@archivo), :prelectura => false, :archivo_excel => @path)
    @archivo_mock.stub!(:lista_hojas).and_return(mock("lista_hojas", :nil? => true))
    @archivo_mock.stub!(:valid?).and_return(true)
    @archivo_mock.stub!(:update_attribute).with(:lista_hojas, kind_of(Array)).and_return(true)
    @archivo_mock.stub!(:lista_hojas).and_return(nil)
    @archivo_mock.stub!(:fecha_modificacion).and_return(Time.now)
    @archivo_mock.stub!(:save).and_return(true)
  end

  before(:each) do
    @valid_attributes = {
      :archivo_id => 1,
      :numero => 0
    }
    mock_archivo()
    Hoja.any_instance.stubs(:archivo).returns(@archivo_mock)

    @usuario_mock = mock_model(Usuario, :id => 1, :nombre => 'Juan', :valid? => true)
    Usuario.stub!(:find).with(kind_of(Fixnum)).and_return(@usuario_mock)
    @us = mock("record", :record => @usuario_mock)
    UsuarioSession.stub!(:find).and_return(@us)

  end

  it "should create a new instance given valid attributes" do
    Hoja.create!(@valid_attributes)
  end

  it "debe retornar la ruta del archivo" do
    @hoja = Hoja.create(@valid_attributes)
    @hoja.ruta.should == File.join(RAILS_ROOT, "ejemplos/#{@hoja.numero}.html")
  end

  it "debe asignar nombre" do
    @hoja = Hoja.create(@valid_attributes)
    @hoja.nombre.should == "Sheet1"
  end

  it "debe generar un archivo HTML" do
    @valid_attributes[:numero] = 2
    @hoja = Hoja.create(@valid_attributes)
    File.exists?(@hoja.ruta)
    @hoja.nombre.should == "Tres"
    @hoja.numero.should == 2
  end

  it "debe generar un archivo HTML y hoja 0" do
    @hoja = Hoja.create(@valid_attributes)
    @hoja.numero.should == 0
    File.exists?(@hoja.ruta)
  end

  it "debe asignar correctamente los ids al HTML" do
    @hoja = Hoja.create(@valid_attributes)
    html = File.open(@hoja.ruta){|f| Hpricot f}
    html.search("tr:eq(0) td:eq(0)").attr("id").should == "1_1"
    html.search("tr:eq(22) td:eq(0)").attr("id").should == "23_1"
    html.search("tr:eq(22) td:eq(1)").attr("id").should == "23_4"
    html.search("tr:eq(23) td:eq(0)").attr("id").should == "24_1"
    html.search("tr:eq(26) td:eq(0)").attr("id").should == "27_1"
    html.search("tr:eq(24) td:eq(0)").attr("id").should == "25_2"
    html.search("tr:eq(24) td:eq(1)").attr("id").should == "25_4"
  end

  it "debe ejecutar prelectura en caso de que este seleccionado" do
    @archivo_mock.stub!(:prelectura).and_return(true)
    @valid_attributes[:numero] = 1
    @hoja = Hoja.create(@valid_attributes)

    html = File.open(@hoja.ruta){|f| Hpricot f}
    excel = Excel.new(File.join(RAILS_ROOT, "ejemplos", "example.xls"))
    excel.default_sheet = @hoja.numero + 1
    html.search("tr:eq(6) td:eq(1)").inner_text.should == excel.cell(7, "B").to_s
    html.search("tr:eq(18) td:eq(1)").inner_text.should == excel.cell(19, "B").to_s
    html.search("tr:eq(36) td:eq(5)").inner_text.should == excel.cell(37, "F").to_s

  end

  describe "Metodos que dependen de Archivo" do


    it "debe crear si no hay hoja en el archivo y asignar la fecha modificacion" do
      now = Time.zone.now + 10
      @archivo_mock.stubs(:fecha_modificacion).returns(now)
      Hoja.any_instance.stubs(:archivo).returns(@archivo_mock)
      @hoja = Hoja.buscar_o_crear(1, 0)
      @hoja.fecha_archivo.to_s.should == now.to_s
    end

    it "debe actualizar la fecha de modificacion y el archivo si el archivo cambia su fecha" do
      @hoja = Hoja.create(@valid_attributes)
      @hoja2 = Hoja.buscar_o_crear(1, 0)
      @hoja.fecha_archivo.should == @hoja2.fecha_archivo

      file_time = File.atime(@hoja.ruta)
      
      now = @hoja.fecha_archivo
      sleep(1)
      @archivo_mock.stubs(:fecha_modificacion).returns((now + 10))
      Hoja.any_instance.stubs(:archivo).returns(@archivo_mock)
      @hoja = Hoja.buscar_o_crear(1, 0)
      @hoja.fecha_archivo.to_s.should_not == now.to_s

      # test para poder ver lo hora del archivo, realizado en este mismo caso debido a que los tests se han vuelto
      # muy intensivos en el procesador (Largos)
      file_time.to_s.should_not == File.atime(@hoja.ruta).to_s
    end
  end

end
