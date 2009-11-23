require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AreasController do

  def mock_area(stubs={})
    @mock_area ||= mock_model(Area, stubs)
  end

  describe "GET index" do
    it "assigns all areases as @areases" do
      Area.stub!(:find).with(:all).and_return([mock_area])
      get :index
      assigns[:areas].should == [mock_area]
    end
  end

  describe "GET show" do
    it "should response to @area with JSON" do
      Area.stub!(:find).with("37").and_return(mock_area)
      #get :show, :id => "37"
      #response.layout.should == false
    end
  end

  describe "GET new" do
    it "assigns a new area as @area" do
      Area.stub!(:new).and_return(mock_area)
      get :new
      assigns[:area].should equal(mock_area)
    end
  end

  describe "GET edit" do
    it "assigns the requested area as @area" do
      Area.stub!(:find).with("37").and_return(mock_area)
      get :edit, :id => "37"
      assigns[:area].should equal(mock_area)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created area as @area" do
        Area.stub!(:new).with({'these' => 'params'}).and_return(mock_area(:save => true))
        post :create, :area => {:these => 'params'}
        assigns[:area].should equal(mock_area)
      end

      it "redirects to the created area" do
        Area.stub!(:new).and_return(mock_area(:save => true))
        post :create, :area => {}
        response.should redirect_to(area_url(mock_area))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved area as @area" do
        Area.stub!(:new).with({'these' => 'params'}).and_return(mock_area(:save => false))
        post :create, :area => {:these => 'params'}
        assigns[:area].should equal(mock_area)
      end

      it "re-renders the 'new' template" do
        Area.stub!(:new).and_return(mock_area(:save => false))
        post :create, :area => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested area" do
        Area.should_receive(:find).with("37").and_return(mock_area)
        mock_area.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :area => {:these => 'params'}
      end

      it "assigns the requested area as @area" do
        Area.stub!(:find).and_return(mock_area(:update_attributes => true))
        put :update, :id => "1"
        assigns[:area].should equal(mock_area)
      end

      it "redirects to the area" do
        Area.stub!(:find).and_return(mock_area(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(area_url(mock_area))
      end
    end

    describe "with invalid params" do
      it "updates the requested area" do
        Area.should_receive(:find).with("37").and_return(mock_area)
        mock_area.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :area => {:these => 'params'}
      end

      it "assigns the area as @area" do
        Area.stub!(:find).and_return(mock_area(:update_attributes => false))
        put :update, :id => "1"
        assigns[:area].should equal(mock_area)
      end

      it "re-renders the 'edit' template" do
        Area.stub!(:find).and_return(mock_area(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested area" do
      Area.should_receive(:find).with("37").and_return(mock_area)
      mock_area.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the areas list" do
      Area.stub!(:find).and_return(mock_area(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(areas_url)
    end
  end

end
