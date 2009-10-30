require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/hojas/index.html.erb" do
  include HojasHelper

  before(:each) do
    assigns[:hojas] = [
      stub_model(Hoja,
        :archivo => 1,
        :nombre => "value for nombre",
        :numero => 1
      ),
      stub_model(Hoja,
        :archivo => 1,
        :nombre => "value for nombre",
        :numero => 1
      )
    ]
  end

  it "renders a list of hojas" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for nombre".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
