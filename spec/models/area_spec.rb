require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Area do
  before(:each) do
    @hoja_mock = mock_model(Hoja, :id => 1, :destroyed? => true)

    @valid_attributes = {
      :hoja => @hoja_mock,
      :nombre => "value for nombre",
      :celda_inicial => "value for celda_inicial",
      :celda_final => "value for celda_final",
      :rango => 1,
      :fija => false,
      :iterar_fila => false,
      :encabezado => {},
      :fin => {},
      :titular => {},
      :descartar => {},
      :sinonimos => {}
    }
  end

  it{should belong_to(:hoja)}

  it "should create a new instance given valid attributes" do
    @a = Area.create!(@valid_attributes)
  end
end
