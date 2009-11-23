require 'spec_helper'

describe "/areas/edit.html.erb" do
  include AreasHelper

  before(:each) do
    assigns[:area] = @area = stub_model(Area,
      :new_record? => false,
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

  it "renders the edit area form" do
    render

    response.should have_tag("form[action=#{area_path(@area)}][method=post]") do
      with_tag('input#area_hoja[name=?]', "area[hoja]")
      with_tag('input#area_nombre[name=?]', "area[nombre]")
      with_tag('input#area_celda_inicial[name=?]', "area[celda_inicial]")
      with_tag('input#area_celda_final[name=?]', "area[celda_final]")
      with_tag('input#area_tipo[name=?]', "area[tipo]")
      with_tag('input#area_rango[name=?]', "area[rango]")
      with_tag('input#area_fija[name=?]', "area[fija]")
      with_tag('input#area_iterar_fila[name=?]', "area[iterar_fila]")
      with_tag('textarea#area_encabezado[name=?]', "area[encabezado]")
      with_tag('textarea#area_titular[name=?]', "area[titular]")
      with_tag('textarea#area_fin[name=?]', "area[fin]")
      with_tag('textarea#area_no_importar[name=?]', "area[no_importar]")
    end
  end
end
