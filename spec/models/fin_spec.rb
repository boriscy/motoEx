require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fin do
  before(:each) do
    archivo = "VentasPrecio2000-2008"
    @params = YAML::parse( File.open( Soporte::path("areas", "#{archivo}.yml") ) ).transform['area']['fin']
    @hoja_electronica = Soporte::hoja_electronica("#{archivo}.xls")
  end

  it "debe crear una hoja electronica" do
    Fin.new(@params, @hoja_electronica)
  end

  it "debe asignar correctamente celda inicial y final" do
    @fin = Fin.new(@params, @hoja_electronica)
    @fin.celda_inicial.should == "19_1"
    @fin.celda_final.should == "19_7"
  end

  it "debe asignar correctamente campos" do
    @fin = Fin.new(@params, @hoja_electronica)
    @fin.campos['19_1']['texto'].should == "TOTAL 2000"
  end

  it 'debe encontrar el final' do
    @fin = Fin.new(@params, @hoja_electronica)
    @fin.fin?(4).should == false
    @fin.fin?(19).should == true
  end

end
