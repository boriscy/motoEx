require 'spec_helper'

describe SinonimosController do

  def mock_sinonimo(stubs={})
    @mock_sinonimo ||= mock_model(Sinonimo, stubs)
  end

  describe "GET index" do
    it "assigns all sinonimoses as @sinonimoses" do
      Sinonimo.stub!(:find).with(:all).and_return([mock_sinonimo])
      get :index
      assigns[:sinonimos].should == [mock_sinonimo]
    end
  end

  describe "GET show" do
    it "assigns the requested sinonimo as @sinonimo" do
      Sinonimo.stub!(:find).with("37").and_return(mock_sinonimo)
      get :show, :id => "37"
      assigns[:sinonimo].should equal(mock_sinonimo)
    end
  end

  describe "GET new" do
    it "assigns a new sinonimo as @sinonimo" do
      Sinonimo.stub!(:new).and_return(mock_sinonimo)
      get :new
      assigns[:sinonimo].should equal(mock_sinonimo)
    end
  end

  describe "GET edit" do
    it "assigns the requested sinonimo as @sinonimo" do
      Sinonimo.stub!(:find).with("37").and_return(mock_sinonimo)
      get :edit, :id => "37"
      assigns[:sinonimo].should equal(mock_sinonimo)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created sinonimo as @sinonimo" do
        Sinonimo.stub!(:new).with({'these' => 'params'}).and_return(mock_sinonimo(:save => true))
        post :create, :sinonimo => {:these => 'params'}
        assigns[:sinonimo].should equal(mock_sinonimo)
      end

      it "redirects to the created sinonimo" do
        Sinonimo.stub!(:new).and_return(mock_sinonimo(:save => true))
        post :create, :sinonimo => {}
        response.should redirect_to(sinonimo_url(mock_sinonimo))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved sinonimo as @sinonimo" do
        Sinonimo.stub!(:new).with({'these' => 'params'}).and_return(mock_sinonimo(:save => false))
        post :create, :sinonimo => {:these => 'params'}
        assigns[:sinonimo].should equal(mock_sinonimo)
      end

      it "re-renders the 'new' template" do
        Sinonimo.stub!(:new).and_return(mock_sinonimo(:save => false))
        post :create, :sinonimo => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested sinonimo" do
        Sinonimo.should_receive(:find).with("37").and_return(mock_sinonimo)
        mock_sinonimo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :sinonimo => {:these => 'params'}
      end

      it "assigns the requested sinonimo as @sinonimo" do
        Sinonimo.stub!(:find).and_return(mock_sinonimo(:update_attributes => true))
        put :update, :id => "1"
        assigns[:sinonimo].should equal(mock_sinonimo)
      end

      it "redirects to the sinonimo" do
        Sinonimo.stub!(:find).and_return(mock_sinonimo(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(sinonimo_url(mock_sinonimo))
      end
    end

    describe "with invalid params" do
      it "updates the requested sinonimo" do
        Sinonimo.should_receive(:find).with("37").and_return(mock_sinonimo)
        mock_sinonimo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :sinonimo => {:these => 'params'}
      end

      it "assigns the sinonimo as @sinonimo" do
        Sinonimo.stub!(:find).and_return(mock_sinonimo(:update_attributes => false))
        put :update, :id => "1"
        assigns[:sinonimo].should equal(mock_sinonimo)
      end

      it "re-renders the 'edit' template" do
        Sinonimo.stub!(:find).and_return(mock_sinonimo(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested sinonimo" do
      Sinonimo.should_receive(:find).with("37").and_return(mock_sinonimo)
      mock_sinonimo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the sinonimos list" do
      Sinonimo.stub!(:find).and_return(mock_sinonimo(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(sinonimos_url)
    end
  end

end
