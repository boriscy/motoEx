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


  it "debe buscar el encabezado" do
    @encabezado = Encabezado.new(@params, @hoja_electronica)
    #debugger
    @encabezado.buscar(@rango).should == 3
  end


end
