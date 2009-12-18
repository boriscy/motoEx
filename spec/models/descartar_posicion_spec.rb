require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
# Importar datos para test
require File.expand_path(File.dirname(__FILE__) + '/../testdata/test1')

describe DescartarPosicion do

  it "debe crear el area" do
    @descartar = DescartarPosicion.new(@@params['desc0'], @@hoja_electronica)
    @descartar.descartada.should == false
    @descartar.fila_inicial.should == 19
  end
end
