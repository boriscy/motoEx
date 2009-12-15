require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AreaEsp do
  before(:each) do
    @celdas = [{'pos' => '3_1', 'texto' => ''}, {'pos' => '3_2', 'texto' => 'Si'},
      {'pos' => '3_3', 'texto' => ''}, {'pos' => '3_4', 'texto' => 'Eco'}, {'pos' => '3_5', 'texto' => 's'}
    ]
    @campos = {
      '3_1' => {'campo' => 'uno','texto' => 'Uno'},
      '3_2' => {'campo' => 'dos','texto' => 'DOS'},
      '4_1' => {'campo' => 'tres','texto' => 'Tres'}
    }
    @params = {
      'celda_inicial' => '3_1',
      'celda_final' => '4_6',
      'celdas' => @celdas,
      'campos' => @campos
    }
    @hoja_electronica = Object
    @hoja_electronica.stub!(:class).and_return(Excel)
  end

  it "debe crear un area inicial con datos válidos" do
    @area_esp = AreaEsp.new(@params, @hoja_electronica)

    @area_esp.celda_inicial.should == @params['celda_inicial']
    @area_esp.celda_final.should == @params['celda_final']
  end

  it "debe eliminar las celdas que no tienen valores" do
    @area_esp = AreaEsp.new(@params, @hoja_electronica)

    @area_esp.celdas.each do |v|
      v['texto'].strip.should_not == ''
    end
  end

  it "debe desplazar a todas las celdas" do
    @area_esp = AreaEsp.new(@params, @hoja_electronica)

    @area_esp.actualizar_posicion(-1)
    @area_esp.campos['2_1']['campo'].should == 'uno'
    @area_esp.campos['2_2']['texto'].should == 'DOS'
    @area_esp.campos['3_1']['campo'].should == 'tres'

  end

end
