require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Titular do
  before(:each) do
    @params = {
      'celda_inicial' => '3_1',
      'celda_final' => '3_7',
      'celdas' => [{'pos' => '5_1', 'texto' => 'a'},
      {'pos' => '5_2', 'texto' => 'b'},{'pos' => '5_3', 'texto' => 'c'},
      {'pos' => '5_4', 'texto' => 'c'},{'pos' => '5_5', 'texto' => 'c'},
      {'pos' => '5_6', 'texto' => 'c'},{'pos' => '5_7', 'texto' => 'c'},
      {'pos' => '6_2', 'texto' => 'c'}]
    }
    @hoja_electronica = Excel.new(File.join(File.expand_path(RAILS_ROOT), "ejemplos", "VentasPrecio2000-2008.xls") )
    @rango = 5
  end

  it "debe retornar los datos" do
    @titular = Titular.new(@params, @hoja_electronica)
    @titular.obtener_titular.should == "DESTINO ARGENTINA BG COMGAS CUIABA GSA MERCADO \nINTERNO TOTAL GN (EN MMBTU)"

    @params['celdas'] = [{'pos' => '3_1', 'texto' => 'S'}]
    @titular = Titular.new(@params, @hoja_electronica)
    @titular.obtener_titular.should == "VENTAS DE GAS NATURAL\nGESTIÓN 2000"
  end
end
