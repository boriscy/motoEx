require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/archivos/new.html.erb" do
  include ArchivosHelper

  before(:each) do
    assigns[:archivo] = stub_model(Archivo,
      :new_record? => true,
      :nombre => "value for nombre",
      :descripcion => "value for descripcion",
      :usuario => 1,
      :archivo_html => "value for archivo_html",
      :archivo_excel => "value for archivo_excel"
    )
  end

  it "renders new archivo form" do
    render

    response.should have_tag("form[action=?][method=post]", archivos_path) do
      with_tag("input#archivo_nombre[name=?]", "archivo[nombre]")
      with_tag("textarea#archivo_descripcion[name=?]", "archivo[descripcion]")
      with_tag("input#archivo_usuario[name=?]", "archivo[usuario]")
      with_tag("input#archivo_archivo_html[name=?]", "archivo[archivo_html]")
      with_tag("input#archivo_archivo_excel[name=?]", "archivo[archivo_excel]")
    end
  end
end
