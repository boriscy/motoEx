require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AreaGeneral do
  before(:each) do

    @titular = {}
    @encabezado = {}
    @descartadas = {}
    @fin = {}

    @params = {
      'celda_inicial' => '1_2',
      'celda_final' => '3_4',
      'titular' => @titular,
      'encabezado' => @encabezado,
      'descartar' => @descartadas,
      'fin' => @fin,
      'nombre' => 'Prueba',
      'rango' => 5,
      'iterar_fila' => true
    }
  end

  it "debe crear area valida" do
    @area_gen = AreaGeneral.new(@params)

    @area_gen.titular.should_not == nil
    @area_gen.encabezado.should_not == nil
    @area_gen.descartadas.should_not == nil
    @area_gen.fin.should_not == nil

    @area_gen.rango.class.should == Fixnum
    @area_gen.nombre.class.should == String
    @area_gen.iterar_fila.should == (@params['iterar_fila'] == true)
    
  end
end
