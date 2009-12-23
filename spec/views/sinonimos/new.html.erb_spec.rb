require 'spec_helper'

describe "/sinonimos/new.html.erb" do
  include SinonimosHelper

  before(:each) do
    assigns[:sinonimo] = stub_model(Sinonimo,
      :new_record? => true,
      :nombre => "value for nombre",
      :mapeado => "value for mapeado"
    )
  end

  it "renders new sinonimo form" do
    render

    response.should have_tag("form[action=?][method=post]", sinonimos_path) do
      with_tag("input#sinonimo_nombre[name=?]", "sinonimo[nombre]")
      with_tag("textarea#sinonimo_mapeado[name=?]", "sinonimo[mapeado]")
    end
  end
end
