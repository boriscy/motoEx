require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Encabezado do
  before(:each) do
    @params = {
      'celda_inicial' => '2_1',
      'celda_final' => '3_7',
      'campos' => {
        '2_1' => {'campo' => 'destino', 'texto' => 'DESTINO'},
        '2_3' => {'campo' => 'bg_comgas', 'texto' => 'BG COMGAS'},
        '2_7' => {'campo' => 'total_gn', 'texto' => 'TOTAL GN'}
      },
      'celdas' => []
    }
    @hoja_electronica = Excel.new(File.join(File.expand_path(RAILS_ROOT), "ejemplos", "VentasPrecio2000-2008.xls") )
    @rango = 5
  end

  def mock_hoja_electronica
    @hoja_electronica = Object
    @hoja_electronica.stub!(:class).and_return(Excel)
  end

  it 'debe aumentar las posiciones de acuerdo a si itera filas' do
    @encabezado = Encabezado.new(@params, @hoja_electronica, true)
    @encabezado.campos['2_1']['posicion'].should == 1
    @encabezado.campos['2_7']['posicion'].should == 7
  end

  # En este caso la prueba funciona pero el dato esta mapeado para filas y no columnas
  it 'debe aumentar las posiciones de acuerdo a si itera columnas' do
    @encabezado = Encabezado.new(@params, @hoja_electronica, false)
    @encabezado.campos['2_1']['posicion'].should == 2
    @encabezado.campos['2_3']['posicion'].should == 2
  end

  it 'debe ' do
    @encabezado = Encabezado.new(@params, @hoja_electronica)
    @encabezado.proc_pos_enc.call(5, @encabezado.campos['2_1']).should == [5, 1]
  end

  it 'debe retornar hash con los campos' do
    @encabezado = Encabezado.new(@params, @hoja_electronica, true)
    @encabezado.extraer_datos(10).should == {'destino' => 'ABRIL', 'bg_comgas' => '', 'total_gn' => '7914534.0'}
  end


  describe "buscar y actualizar posiciones" do

    before do
      @encabezado = Encabezado.new(@params, @hoja_electronica)
    end

    it "debe buscar el encabezado" do
      @encabezado.buscar(@rango).should == 3
    end

    it "debe actualizar campos" do
      @encabezado.buscar(@rango)

      @encabezado.campos['5_1']['texto'].should == 'DESTINO'
      @encabezado.campos['5_3']['texto'].should == 'BG COMGAS'
      @encabezado.campos['5_7']['texto'].should == 'TOTAL GN'
      @encabezado.campos['5_7']['campo'].should == 'total_gn'
    end

  end

  describe "Importar otra hoja" do
    before(:each) do
      enc = YAML::parse(File.open(RAILS_ROOT + "/ejemplos/areas/VentasPrecio2003.yml")).transform
      @area = enc['area']['encabezado']
      @hoja_electronica = Excel.new(RAILS_ROOT + "/ejemplos/VentasPrecio2003.xls")
    end

    it 'debe encontrar el area correcta' do
      @encabezado = Encabezado.new(@area, @hoja_electronica, true)
      @encabezado.buscar(15).should == 10
    end
    
  end

end
