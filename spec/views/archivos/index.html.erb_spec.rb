require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/archivos/index.html.erb" do
  include ArchivosHelper

  before(:each) do
    assigns[:archivos] = [
      stub_model(Archivo,
        :nombre => "value for nombre",
        :descripcion => "value for descripcion",
        :usuario => 1,
        :archivo_html => "value for archivo_html",
        :archivo_excel => "value for archivo_excel"
      ),
      stub_model(Archivo,
        :nombre => "value for nombre",
        :descripcion => "value for descripcion",
        :usuario => 1,
        :archivo_html => "value for archivo_html",
        :archivo_excel => "value for archivo_excel"
      )
    ]
  end

  it "renders a list of archivos" do
    render
    response.should have_tag("tr>td", "value for nombre".to_s, 2)
    response.should have_tag("tr>td", "value for descripcion".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for archivo_html".to_s, 2)
    response.should have_tag("tr>td", "value for archivo_excel".to_s, 2)
  end
end
