require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HojasController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "hojas", :action => "index").should == "/hojas"
    end

    it "maps #new" do
      route_for(:controller => "hojas", :action => "new").should == "/hojas/new"
    end

    it "maps #show" do
      route_for(:controller => "hojas", :action => "show", :id => "1").should == "/hojas/1"
    end

    it "maps #edit" do
      route_for(:controller => "hojas", :action => "edit", :id => "1").should == "/hojas/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "hojas", :action => "create").should == {:path => "/hojas", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "hojas", :action => "update", :id => "1").should == {:path =>"/hojas/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "hojas", :action => "destroy", :id => "1").should == {:path =>"/hojas/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/hojas").should == {:controller => "hojas", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/hojas/new").should == {:controller => "hojas", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/hojas").should == {:controller => "hojas", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/hojas/1").should == {:controller => "hojas", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/hojas/1/edit").should == {:controller => "hojas", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/hojas/1").should == {:controller => "hojas", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/hojas/1").should == {:controller => "hojas", :action => "destroy", :id => "1"}
    end
  end
end
