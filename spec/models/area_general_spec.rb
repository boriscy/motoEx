require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AreaGeneral do
  before(:each) do

    @titular = {}
    @encabezado = {"celdas"=>[{"texto"=>"DESTINO", "pos"=>"5_1"}, {"texto"=>"ARGENTINA", "pos"=>"5_2"}, 
      {"texto"=>"BG COMGAS", "pos"=>"5_3"}, {"texto"=>"CUIABA", "pos"=>"5_4"}, 
      {"texto"=>"GSA", "pos"=>"5_5"}, {"texto"=>"MERCADO  INTERNO", "pos"=>"5_6"},
      {"texto"=>"TOTAL GN", "pos"=>"5_7"}, {"texto"=>"(EN MMBTU)", "pos"=>"6_2"}], 
      "campos"=>{"5_5"=>{"campo"=>"gsa", "texto"=>"GSA"}, "5_7"=>{"campo"=>"total_gn", "texto"=>"TOTAL GN"},
      "5_1"=>{"campo"=>"destino", "texto"=>"DESTINO"}, "5_2"=>{"campo"=>"argentina", "texto"=>"ARGENTINA"}},
      "celda_final"=>"6_7", "celda_inicial"=>"5_1"}

    @descartadas = {
    "desc1"=>{"celdas"=>[{"texto"=>"ABRIL", "id"=>"0_10_1"}, 
      {"texto"=>" ", "id"=>"0_10_2"}, {"texto"=>" ", "id"=>"0_10_3"}, {"texto"=>" ", "id"=>"0_10_4"},
      {"texto"=>"4,894,744.80", "id"=>"0_10_5"}, {"texto"=>"3,019,789.20", "id"=>"0_10_6"}, 
      {"texto"=>"7,914,534.00", "id"=>"0_10_7"}], "patron"=>{"excepciones"=>[], "2"=>{"texto"=>" "}},
      "celda_final"=>"10_7", "celda_inicial"=>"10_1"}, 
    "desc0"=>{"celdas"=>[{"texto"=>" TOTAL 2000", "id"=>"0_19_1"}, 
      {"texto"=>"693,590.00", "id"=>"0_19_2"}, {"texto"=>"0.00", "id"=>"0_19_3"},
      {"texto"=>"0.00", "id"=>"0_19_4"}, {"texto"=>"75,197,776.90", "id"=>"0_19_5"},
      {"texto"=>"39,042,206.31", "id"=>"0_19_6"}, {"texto"=>"114,933,573.21", "id"=>"0_19_7"}],
      "patron"=>{"excepciones"=>[]}, "celda_final"=>"19_7", "celda_inicial"=>"19_1"}}
  
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
    @hoja_electronica = Excel.new(File.join(File.expand_path(RAILS_ROOT), "ejemplos", "VentasPrecios2000-2008.xls") )

  end

  it "debe crear area valida" do
    @area_gen = AreaGeneral.new(@params, @hoja_electronica)

    @area_gen.titular.should_not == nil
    @area_gen.encabezado.should_not == nil
    @area_gen.descartadas.should_not == nil
    @area_gen.fin.should_not == nil

    @area_gen.rango.class.should == Fixnum
    @area_gen.nombre.class.should == String
    @area_gen.iterar_fila.should == (@params['iterar_fila'] == true)
  end
end
