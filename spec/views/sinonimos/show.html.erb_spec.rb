require 'spec_helper'

describe "/sinonimos/show.html.erb" do
  include SinonimosHelper
  before(:each) do
    assigns[:sinonimo] = @sinonimo = stub_model(Sinonimo,
      :nombre => "value for nombre",
      :mapeado => "value for mapeado"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ nombre/)
    response.should have_text(/value\ for\ mapeado/)
  end
end
