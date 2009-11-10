require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HojasController do

  def mock_hoja(stubs={})
    @mock_hoja ||= mock_model(Hoja, stubs)
  end

  before(:each) do
    @us = mock("record", :record => mock_model(Usuario, :id => 1, :nombre => 'Juan', :valid? => true))
    UsuarioSession.stub!(:find).and_return(@us)
  end

  describe "GET show" do
    it "assigns the requested hoja as @hoja" do
      Hoja.stub!(:find).with("37").and_return(mock_hoja)
      get :show, :id => "37"
      assigns[:hoja].should equal(mock_hoja)
    end
  end

end
