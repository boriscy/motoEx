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

  it "debe eliminar las celdas que no tienen valores (Vacios)" do
    @area_esp = AreaEsp.new(@params, @hoja_electronica)

    @area_esp.celdas.each do |v|
      v['texto'].strip.should_not == ''
    end
  end

  describe "Actualizacion de posiciones" do

    before(:each) do
      @celdas = [{'pos' => '3_2', 'texto' => ''}, {'pos' => '3_3', 'texto' => 'Si'},
        {'pos' => '3_4', 'texto' => ''}, {'pos' => '3_5', 'texto' => 'Eco'}, {'pos' => '3_6', 'texto' => 's'}
      ]
      @campos = {
        '3_2' => {'campo' => 'uno','texto' => 'Uno'},
        '3_3' => {'campo' => 'dos','texto' => 'DOS'},
        '4_2' => {'campo' => 'tres','texto' => 'Tres'}
      }
      @params['campos'] = @campos
      @params['celdas'] = @celdas

      @area_esp = AreaEsp.new(@params, @hoja_electronica, false)
    end

    it "cuando el rango es negativo" do
      @area_esp.actualizar_posicion(-2, -1)
      @area_esp.campos['1_1']['campo'].should == 'uno'
      @area_esp.campos['1_2']['texto'].should == 'DOS'
      @area_esp.campos['2_1']['campo'].should == 'tres'
    end

    it "cuando el rango es positivo" do
      @area_esp.actualizar_posicion(2, 1)
      @area_esp.campos['5_3']['campo'].should == 'uno'
      @area_esp.campos['5_4']['texto'].should == 'DOS'
      @area_esp.campos['6_3']['campo'].should == 'tres'
    end

    it "celdas positivo" do
      @area_esp.actualizar_posicion(2, 3)
      @area_esp.celdas[0]['pos'].should == '5_6'
      @area_esp.celdas[0]['texto'].should == 'Si'

      @area_esp.celdas[1]['pos'].should == '5_8'
      @area_esp.celdas[1]['texto'].should == 'Eco'

      @area_esp.celdas[2]['pos'].should == '5_9'
      @area_esp.celdas[2]['texto'].should == 's'
    end

    it "celdas negativo" do
      @area_esp.actualizar_posicion(-2, -1)
      @area_esp.celdas[0]['pos'].should == '1_2'
      @area_esp.celdas[0]['texto'].should == 'Si'

      @area_esp.celdas[1]['pos'].should == '1_4'
      @area_esp.celdas[1]['texto'].should == 'Eco'

      @area_esp.celdas[2]['pos'].should == '1_5'
      @area_esp.celdas[2]['texto'].should == 's'
    end
  end

end
