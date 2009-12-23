require 'spec_helper'

describe "/sinonimos/index.html.erb" do
  include SinonimosHelper

  before(:each) do
    assigns[:sinonimos] = [
      stub_model(Sinonimo,
        :nombre => "value for nombre",
        :mapeado => "value for mapeado"
      ),
      stub_model(Sinonimo,
        :nombre => "value for nombre",
        :mapeado => "value for mapeado"
      )
    ]
  end

  it "renders a list of sinonimos" do
    render
    response.should have_tag("tr>td", "value for nombre".to_s, 2)
    response.should have_tag("tr>td", "value for mapeado".to_s, 2)
  end
end
