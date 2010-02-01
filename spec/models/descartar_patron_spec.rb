require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
# Importar datos para test
require File.expand_path(File.dirname(__FILE__) + '/../testdata/test1')

describe DescartarPatron do

  it "debe borrar espacion en blanco al final y principio patron" do
    @descartar = DescartarPatron.new(@@descartar['desc1'], @@hoja_electronica)
    @descartar.patron.should == {"2"=>{"texto"=>""}} 
  end

  it "debe borrar espacion en blanco al final y principio excepciones" do
    @descartar = DescartarPatron.new(@@descartar['desc1'], @@hoja_electronica)
    @descartar.excepciones.should == [ [ { 'pos' => '1', 'texto' => 'MAYO' } ] ]
  end

  it "debe indicar patron es valido" do
    @descartar = DescartarPatron.new(@@descartar['desc1'], @@hoja_electronica)

    @descartar.valido?(10).should == true
    @descartar.valido?(13).should == true
  end

  it "debe indicar patron invalido si hay excepcion" do
    @descartar = DescartarPatron.new(@@descartar['desc1'], @@hoja_electronica)
    @descartar.valido?(11).should == false
  end

  it "debe indicar patron invalido" do
    @descartar = DescartarPatron.new(@@descartar['desc1'], @@hoja_electronica)

    @descartar.valido?(7).should == false
    @descartar.valido?(14).should == false
  end

  it 'debe actualizar la posicion del patron' do
    @params = {"excepciones"=>[[{"texto"=>"UNO", "pos"=>"3"}], [{"texto"=>"DOS", "pos"=>"4"}], [{"texto"=>"JEWJE", "pos"=>"3"}]], 
      "patron"=>{"1"=>{"texto"=>"BJO"}, "2"=>{"texto"=>"X 44"}},
      "celda_final"=>"85_21", "celda_inicial"=>"85_1"
    }

    @descartar = DescartarPatron.new(@params, @@hoja_electronica)
    @descartar.desplazar_patron(2, 3)

    @descartar.patron['4']['texto'].should == 'BJO'
    @descartar.patron['5']['texto'].should == 'X 44'
    
  end

  describe "Parte Diario" do
    before(:each) do
      area = YAML::parse(File.open(RAILS_ROOT + "/ejemplos/areas/ParteDiario.yml")).transform
      @areas = area['area']['descartar']
      @hoja_electronica = Excel.new(RAILS_ROOT + '/ejemplos/ParteDiario.xls')
    end

    it 'debe descartar con patron TOTAL' do
      # Texto TOTAL
      @descartar = DescartarPatron.new(@areas['desc1'], @hoja_electronica, true)
      @descartar.valido?(27).should == true
    end
  end
end
