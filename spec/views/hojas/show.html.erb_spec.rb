require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/hojas/show.html.erb" do
  include HojasHelper
  before(:each) do
    assigns[:hoja] = @hoja = stub_model(Hoja,
      :archivo => 1,
      :nombre => "value for nombre",
      :numero => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/value\ for\ nombre/)
    response.should have_text(/1/)
  end
end
