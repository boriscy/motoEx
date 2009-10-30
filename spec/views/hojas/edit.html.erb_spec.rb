require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/hojas/edit.html.erb" do
  include HojasHelper

  before(:each) do
    assigns[:hoja] = @hoja = stub_model(Hoja,
      :new_record? => false,
      :archivo => 1,
      :nombre => "value for nombre",
      :numero => 1
    )
  end

  it "renders the edit hoja form" do
    render

    response.should have_tag("form[action=#{hoja_path(@hoja)}][method=post]") do
      with_tag('input#hoja_archivo[name=?]', "hoja[archivo]")
      with_tag('input#hoja_nombre[name=?]', "hoja[nombre]")
      with_tag('input#hoja_numero[name=?]', "hoja[numero]")
    end
  end
end
