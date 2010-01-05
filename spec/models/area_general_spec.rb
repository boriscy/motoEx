require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
# Importar datos para test
require File.expand_path(File.dirname(__FILE__) + '/../testdata/test1')

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

    @fin = {}

    @params = {
      'celda_inicial' => '1_2',
      'celda_final' => '3_4',
      'titular' => @titular,
      'encabezado' => @encabezado,
      'descartar' => @@descartar,
      'fin' => @fin,
      'nombre' => 'Prueba',
      'rango' => 5,
      'fija' => false
    }
    @ret = Object.new
    @ret.stub!(:buscar).and_return(0)
    Encabezado.stub!(:new).and_return(@ret)
    #Encabezado.stub!(:new).and_return(true)
    DescartarPatron.stub!(:new).and_return("DescartarPatron")
    Titular.stub!(:new).and_return(true)
    Fin.stub!(:new).and_return(true)

  end

  it "debe crear area valida" do
    @area_gen = AreaGeneral.new(@params, @@hoja_electronica, true)

    @area_gen.titular.should_not == nil
    @area_gen.encabezado.should_not == nil
    @area_gen.descartadas_posicion.should_not == nil
    @area_gen.descartadas_patron.should_not == nil
    @area_gen.fin.should_not == nil

    @area_gen.rango.class.should == Fixnum
    @area_gen.nombre.class.should == String
  end

  it "debe asignar las areas de descarte por posicion" do
    @area_gen = AreaGeneral.new(@params, @@hoja_electronica, true)
    @area_gen.descartadas_posicion.size.should == 1
    @area_gen.descartadas_posicion[19].should == true
  end

  it "debe actualizar la posicion de areas descartadas pos posicion" do
    @area_gen = AreaGeneral.new(@params, @@hoja_electronica, true)
    @area_gen.actualizar_descartadas_posicion(2)
    @area_gen.descartadas_posicion[21].should == true
  end

  it "debe asignar las areas de descarta patron" do
    @area_gen = AreaGeneral.new(@params, @@hoja_electronica, true)
    @area_gen.descartadas_patron.size.should == 1
    @area_gen.descartadas_patron['desc1'].should == "DescartarPatron"
  end
end
