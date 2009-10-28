require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/archivos/show.html.erb" do
  include ArchivosHelper
  before(:each) do
    assigns[:archivo] = @archivo = stub_model(Archivo,
      :nombre => "value for nombre",
      :descripcion => "value for descripcion",
      :usuario => 1,
      :archivo_html => "value for archivo_html",
      :archivo_excel => "value for archivo_excel"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nombre/)
    response.should have_text(/value\ for\ descripcion/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ archivo_html/)
    response.should have_text(/value\ for\ archivo_excel/)
  end
end
