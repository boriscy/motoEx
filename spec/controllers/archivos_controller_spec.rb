require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ArchivosController do

  def mock_archivo(stubs={})
    @mock_archivo ||= mock_model(Archivo, stubs)
  end

  describe "GET index" do
    it "assigns all archivoses as @archivoses" do
      Archivo.stub!(:find).with(:all).and_return([mock_archivo])
      get :index
      assigns[:archivos].should == [mock_archivo]
    end
  end

  describe "GET show" do
    it "assigns the requested archivo as @archivo" do
      Archivo.stub!(:find).with("37").and_return(mock_archivo)
      get :show, :id => "37"
      assigns[:archivo].should equal(mock_archivo)
    end
  end

  describe "GET new" do
    it "assigns a new archivo as @archivo" do
      Archivo.stub!(:new).and_return(mock_archivo)
      get :new
      assigns[:archivo].should equal(mock_archivo)
    end
  end

  describe "GET edit" do
    it "assigns the requested archivo as @archivo" do
      Archivo.stub!(:find).with("37").and_return(mock_archivo)
      get :edit, :id => "37"
      assigns[:archivo].should equal(mock_archivo)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created archivo as @archivo" do
        Archivo.stub!(:new).with({'these' => 'params'}).and_return(mock_archivo(:save => true))
        post :create, :archivo => {:these => 'params'}
        assigns[:archivo].should equal(mock_archivo)
      end

      it "redirects to the created archivo" do
        Archivo.stub!(:new).and_return(mock_archivo(:save => true))
        post :create, :archivo => {}
        response.should redirect_to(archivo_url(mock_archivo))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved archivo as @archivo" do
        Archivo.stub!(:new).with({'these' => 'params'}).and_return(mock_archivo(:save => false))
        post :create, :archivo => {:these => 'params'}
        assigns[:archivo].should equal(mock_archivo)
      end

      it "re-renders the 'new' template" do
        Archivo.stub!(:new).and_return(mock_archivo(:save => false))
        post :create, :archivo => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested archivo" do
        Archivo.should_receive(:find).with("37").and_return(mock_archivo)
        mock_archivo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :archivo => {:these => 'params'}
      end

      it "assigns the requested archivo as @archivo" do
        Archivo.stub!(:find).and_return(mock_archivo(:update_attributes => true))
        put :update, :id => "1"
        assigns[:archivo].should equal(mock_archivo)
      end

      it "redirects to the archivo" do
        Archivo.stub!(:find).and_return(mock_archivo(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(archivo_url(mock_archivo))
      end
    end

    describe "with invalid params" do
      it "updates the requested archivo" do
        Archivo.should_receive(:find).with("37").and_return(mock_archivo)
        mock_archivo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :archivo => {:these => 'params'}
      end

      it "assigns the archivo as @archivo" do
        Archivo.stub!(:find).and_return(mock_archivo(:update_attributes => false))
        put :update, :id => "1"
        assigns[:archivo].should equal(mock_archivo)
      end

      it "re-renders the 'edit' template" do
        Archivo.stub!(:find).and_return(mock_archivo(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested archivo" do
      Archivo.should_receive(:find).with("37").and_return(mock_archivo)
      mock_archivo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the archivos list" do
      Archivo.stub!(:find).and_return(mock_archivo(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(archivos_url)
    end
  end

end
