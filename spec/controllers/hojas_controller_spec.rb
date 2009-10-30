require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HojasController do

  def mock_hoja(stubs={})
    @mock_hoja ||= mock_model(Hoja, stubs)
  end

  describe "GET index" do
    it "assigns all hojases as @hojases" do
      Hoja.stub!(:find).with(:all).and_return([mock_hoja])
      get :index
      assigns[:hojas].should == [mock_hoja]
    end
  end

  describe "GET show" do
    it "assigns the requested hoja as @hoja" do
      Hoja.stub!(:find).with("37").and_return(mock_hoja)
      get :show, :id => "37"
      assigns[:hoja].should equal(mock_hoja)
    end
  end

  describe "GET new" do
    it "assigns a new hoja as @hoja" do
      Hoja.stub!(:new).and_return(mock_hoja)
      get :new
      assigns[:hoja].should equal(mock_hoja)
    end
  end

  describe "GET edit" do
    it "assigns the requested hoja as @hoja" do
      Hoja.stub!(:find).with("37").and_return(mock_hoja)
      get :edit, :id => "37"
      assigns[:hoja].should equal(mock_hoja)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created hoja as @hoja" do
        Hoja.stub!(:new).with({'these' => 'params'}).and_return(mock_hoja(:save => true))
        post :create, :hoja => {:these => 'params'}
        assigns[:hoja].should equal(mock_hoja)
      end

      it "redirects to the created hoja" do
        Hoja.stub!(:new).and_return(mock_hoja(:save => true))
        post :create, :hoja => {}
        response.should redirect_to(hoja_url(mock_hoja))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hoja as @hoja" do
        Hoja.stub!(:new).with({'these' => 'params'}).and_return(mock_hoja(:save => false))
        post :create, :hoja => {:these => 'params'}
        assigns[:hoja].should equal(mock_hoja)
      end

      it "re-renders the 'new' template" do
        Hoja.stub!(:new).and_return(mock_hoja(:save => false))
        post :create, :hoja => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested hoja" do
        Hoja.should_receive(:find).with("37").and_return(mock_hoja)
        mock_hoja.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :hoja => {:these => 'params'}
      end

      it "assigns the requested hoja as @hoja" do
        Hoja.stub!(:find).and_return(mock_hoja(:update_attributes => true))
        put :update, :id => "1"
        assigns[:hoja].should equal(mock_hoja)
      end

      it "redirects to the hoja" do
        Hoja.stub!(:find).and_return(mock_hoja(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(hoja_url(mock_hoja))
      end
    end

    describe "with invalid params" do
      it "updates the requested hoja" do
        Hoja.should_receive(:find).with("37").and_return(mock_hoja)
        mock_hoja.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :hoja => {:these => 'params'}
      end

      it "assigns the hoja as @hoja" do
        Hoja.stub!(:find).and_return(mock_hoja(:update_attributes => false))
        put :update, :id => "1"
        assigns[:hoja].should equal(mock_hoja)
      end

      it "re-renders the 'edit' template" do
        Hoja.stub!(:find).and_return(mock_hoja(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested hoja" do
      Hoja.should_receive(:find).with("37").and_return(mock_hoja)
      mock_hoja.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the hojas list" do
      Hoja.stub!(:find).and_return(mock_hoja(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(hojas_url)
    end
  end

end
