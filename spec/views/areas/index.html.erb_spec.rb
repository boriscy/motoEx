require 'spec_helper'

describe "/areas/index.html.erb" do
  include AreasHelper

  before(:each) do
    assigns[:areas] = [
      stub_model(Area,
        :hoja => 1,
        :nombre => "value for nombre",
        :celda_inicial => "value for celda_inicial",
        :celda_final => "value for celda_final",
        :tipo => "value for tipo",
        :rango => 1,
        :fija => false,
        :iterar_fila => false,
        :encabezado => "value for encabezado",
        :titular => "value for titular",
        :fin => "value for fin",
        :no_importar => "value for no_importar"
      ),
      stub_model(Area,
        :hoja => 1,
        :nombre => "value for nombre",
        :celda_inicial => "value for celda_inicial",
        :celda_final => "value for celda_final",
        :tipo => "value for tipo",
        :rango => 1,
        :fija => false,
        :iterar_fila => false,
        :encabezado => "value for encabezado",
        :titular => "value for titular",
        :fin => "value for fin",
        :no_importar => "value for no_importar"
      )
    ]
  end

  it "renders a list of areas" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for nombre".to_s, 2)
    response.should have_tag("tr>td", "value for celda_inicial".to_s, 2)
    response.should have_tag("tr>td", "value for celda_final".to_s, 2)
    response.should have_tag("tr>td", "value for tipo".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
    response.should have_tag("tr>td", "value for encabezado".to_s, 2)
    response.should have_tag("tr>td", "value for titular".to_s, 2)
    response.should have_tag("tr>td", "value for fin".to_s, 2)
    response.should have_tag("tr>td", "value for no_importar".to_s, 2)
  end
end
