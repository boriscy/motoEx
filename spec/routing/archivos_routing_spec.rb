require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ArchivosController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "archivos", :action => "index").should == "/archivos"
    end

    it "maps #new" do
      route_for(:controller => "archivos", :action => "new").should == "/archivos/new"
    end

    it "maps #show" do
      route_for(:controller => "archivos", :action => "show", :id => "1").should == "/archivos/1"
    end

    it "maps #edit" do
      route_for(:controller => "archivos", :action => "edit", :id => "1").should == "/archivos/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "archivos", :action => "create").should == {:path => "/archivos", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "archivos", :action => "update", :id => "1").should == {:path =>"/archivos/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "archivos", :action => "destroy", :id => "1").should == {:path =>"/archivos/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/archivos").should == {:controller => "archivos", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/archivos/new").should == {:controller => "archivos", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/archivos").should == {:controller => "archivos", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/archivos/1").should == {:controller => "archivos", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/archivos/1/edit").should == {:controller => "archivos", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/archivos/1").should == {:controller => "archivos", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/archivos/1").should == {:controller => "archivos", :action => "destroy", :id => "1"}
    end
  end
end
