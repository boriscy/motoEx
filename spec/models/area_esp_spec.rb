require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AreaEsp do
  before(:each) do
    @celdas = [{'pos' => '1_2', 'texto' => ''}, {'pos' => '1_3', 'texto' => 'Si'},
      {'pos' => '1_4', 'texto' => ''}, {'pos' => '1_5', 'texto' => 'Eco'}, {'pos' => '1_6', 'texto' => 's'}
    ]
    @params = {
      'celda_inicial' => '1_2',
      'celda_final' => '3_4',
      'celdas' => @celdas
    }
  end

  it "debe crear un area inicial con datos válidos" do
    @area_esp = AreaEsp.new(@params)

    @area_esp.celda_inicial.should == @params['celda_inicial']
    @area_esp.celda_final.should == @params['celda_final']

  end

  it "debe eliminar las celdas que no tienen valoresl" do
    @area_esp = AreaEsp.new(@params)

    @area_esp.celdas.each do |v|
      v['texto'].strip.should_not == ''
    end
  end
end
