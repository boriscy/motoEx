require 'spec_helper'

describe "/sinonimos/edit.html.erb" do
  include SinonimosHelper

  before(:each) do
    assigns[:sinonimo] = @sinonimo = stub_model(Sinonimo,
      :new_record? => false,
      :nombre => "value for nombre",
      :mapeado => "value for mapeado"
    )
  end

  it "renders the edit sinonimo form" do
    render

    response.should have_tag("form[action=#{sinonimo_path(@sinonimo)}][method=post]") do
      with_tag('input#sinonimo_nombre[name=?]', "sinonimo[nombre]")
      with_tag('textarea#sinonimo_mapeado[name=?]', "sinonimo[mapeado]")
    end
  end
end
