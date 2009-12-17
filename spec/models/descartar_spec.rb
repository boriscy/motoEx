require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
# Importar datos para test
require File.expand_path(File.dirname(__FILE__) + '/../testdata/test1')

describe Descartar do

  it "debe tener un area de descarte por patron y otra por posicion fija" do
    @descartar = Descartar.new(@params, @hoja_electronica)
   debugger 
    @descartar.descartadas_patron.keys.size.should == 1
    @descartar.descartadas_posicion.keys.size.should == 1
    #@descartar.descartadas_patron['desc1']['celda_inicial'].should

  end
end
