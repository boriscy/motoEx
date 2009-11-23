require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Area do
  before(:each) do
    @valid_attributes = {
      :hoja_id => 1,
      :nombre => "value for nombre",
      :celda_inicial => "value for celda_inicial",
      :celda_final => "value for celda_final",
      :tipo => "value for tipo",
      :rango => 1,
      :fija => false,
      :iterar_fila => false,
      :encabezado_celda_inicial => "A1",
      :encabezado_celda_final => "B1",
      :titular => "value for titular",
      :fin => "value for fin",
      :no_importar => "value for no_importar"
    }
  end

  it{should belong_to(:hoja)}

  it "should create a new instance given valid attributes" do
    Area.create!(@valid_attributes)
  end
end
