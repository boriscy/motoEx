require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/hojas/new.html.erb" do
  include HojasHelper

  before(:each) do
    assigns[:hoja] = stub_model(Hoja,
      :new_record? => true,
      :archivo => 1,
      :nombre => "value for nombre",
      :numero => 1
    )
  end

  it "renders new hoja form" do
    render

    response.should have_tag("form[action=?][method=post]", hojas_path) do
      with_tag("input#hoja_archivo[name=?]", "hoja[archivo]")
      with_tag("input#hoja_nombre[name=?]", "hoja[nombre]")
      with_tag("input#hoja_numero[name=?]", "hoja[numero]")
    end
  end
end
