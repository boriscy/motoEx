require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ImportaresController do

  def mock_archivo(stubs={})
    @mock_archivos ||= mock_model(Archivo, stubs)
  end

  before(:each) do
    @usario = mock("record", :record => mock_model(Usuario, :id => 1, :nombre => 'Juan', :valid? => true))
    UsuarioSession.stub!(:find).and_return(@us)
  end

  describe "GET index" do
    before(:each) do
      Archivo.stub!(:paginate).and_return([mock_archivo])
    end

    it "debe asignar archivos" do
      get :index
      assigns[:archivos].should == [mock_archivo]
    end
  end

  describe "GET new" do
    before(:each) do
      Archivo.stub!(:find).and_return(mock_archivo)
    end

    it "debe asignar archivo" do
      get :new
      assigns[:archivo].should == mock_archivo
    end
  end

end
