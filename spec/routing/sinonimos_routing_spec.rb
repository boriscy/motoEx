require 'spec_helper'

describe SinonimosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/sinonimos" }.should route_to(:controller => "sinonimos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/sinonimos/new" }.should route_to(:controller => "sinonimos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/sinonimos/1" }.should route_to(:controller => "sinonimos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/sinonimos/1/edit" }.should route_to(:controller => "sinonimos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/sinonimos" }.should route_to(:controller => "sinonimos", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/sinonimos/1" }.should route_to(:controller => "sinonimos", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/sinonimos/1" }.should route_to(:controller => "sinonimos", :action => "destroy", :id => "1") 
    end
  end
end
