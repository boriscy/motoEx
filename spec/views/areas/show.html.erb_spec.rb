require 'spec_helper'

describe "/areas/show.html.erb" do
  include AreasHelper
  before(:each) do
    assigns[:area] = @area = stub_model(Area,
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
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/value\ for\ nombre/)
    response.should have_text(/value\ for\ celda_inicial/)
    response.should have_text(/value\ for\ celda_final/)
    response.should have_text(/value\ for\ tipo/)
    response.should have_text(/1/)
    response.should have_text(/false/)
    response.should have_text(/false/)
    response.should have_text(/value\ for\ encabezado/)
    response.should have_text(/value\ for\ titular/)
    response.should have_text(/value\ for\ fin/)
    response.should have_text(/value\ for\ no_importar/)
  end
end
