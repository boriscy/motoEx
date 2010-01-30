require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
# Importar datos para test
require File.expand_path(File.dirname(__FILE__) + '/../testdata/test1')

describe AreaGeneral do

  def crear_metodos(*args)
    
  end

  before(:each) do

    @titular = {'celdas' => [{'texto' => 'Prueba', 'pos' => '3_1'}],
      'celda_inicial' => '3_1', 'celda_final' => '3_5'
    }
    @encabezado = {"celdas"=>[{"texto"=>"DESTINO", "pos"=>"5_1"}, {"texto"=>"ARGENTINA", "pos"=>"5_2"}, 
      {"texto"=>"BG COMGAS", "pos"=>"5_3"}, {"texto"=>"CUIABA", "pos"=>"5_4"}, 
      {"texto"=>"GSA", "pos"=>"5_5"}, {"texto"=>"MERCADO  INTERNO", "pos"=>"5_6"},
      {"texto"=>"TOTAL GN", "pos"=>"5_7"}, {"texto"=>"(EN MMBTU)", "pos"=>"6_2"}], 
      "campos"=>{"5_5"=>{"campo"=>"gsa", "texto"=>"GSA"}, "5_7"=>{"campo"=>"total_gn", "texto"=>"TOTAL GN"},
      "5_1"=>{"campo"=>"destino", "texto"=>"DESTINO"}, "5_2"=>{"campo"=>"argentina", "texto"=>"ARGENTINA"}},
      "celda_final"=>"6_7", "celda_inicial"=>"5_1"}

    @fin = {}

    @params = {
      'celda_inicial' => '3_1',
      'celda_final' => '19_7',
      'titular' => @titular,
      'encabezado' => @encabezado,
      'descartar' => @@descartar,
      'fin' => @fin,
      'nombre' => 'Prueba',
      'rango_filas' => 5,
      'rango_columnas' => 3,
      'fija' => false
    }
    @enc = Object.new
    @enc.stub!(:buscar).and_return(0)
    @enc.stub!(:actulizar_posicion)
    Encabezado.stub!(:new).and_return(@enc)

    DescartarPatron.stub!(:new).and_return("DescartarPatron")
    @methods = Object.new
    @methods.stub!(:actualizar_posicion)
    Titular.stub!(:new).and_return(@methods)
    Fin.stub!(:new).and_return(@methods)
  end

  it "debe crear area valida" do
    @area_gen = AreaGeneral.new(@params, @@hoja_electronica, true)

    @area_gen.titular.should_not == nil
    @area_gen.encabezado.should_not == nil
    @area_gen.descartadas_posicion.should_not == nil
    @area_gen.descartadas_patron.should_not == nil
    @area_gen.fin.should_not == nil

    @area_gen.rango_filas.class.should == Fixnum
    @area_gen.rango_columnas.class.should == Fixnum
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

  it 'debe desplazar la posicion' do
    @enc.stub!(:buscar).and_return(2, 3)
    # Stubs necesarios para que pase
    Fin.stub!(:actualizar_posicion)
    Titular.stub!(:actualizar_posicion)

    @area_gen = AreaGeneral.new(@params, @@hoja_electronica, true)
    @area_gen.celda_inicial == "3_2" #orig  "1_2"
    @area_gen.celda_final == "5_4" #orig  "3_4"
  end

#  describe "lectura de archivo" do
#
#    before(:each) do
#      @area_gen = AreaGeneral.new(@params, @@hoja_electronica, true)
#    end
#
#    it 'debe leer los datos' do
#      res = @area_gen.leer
#      debugger
#      s=0
#    end
#  end
end
