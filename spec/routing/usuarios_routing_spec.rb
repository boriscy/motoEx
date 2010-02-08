require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsuariosController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "usuarios", :action => "index").should == "/usuarios"
    end

    it "maps #new" do
      route_for(:controller => "usuarios", :action => "new").should == "/usuarios/new"
    end

    it "maps #show" do
      route_for(:controller => "usuarios", :action => "show", :id => "1").should == "/usuarios/1"
    end

    it "maps #edit" do
      route_for(:controller => "usuarios", :action => "edit", :id => "1").should == "/usuarios/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "usuarios", :action => "create").should == {:path => "/usuarios", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "usuarios", :action => "update", :id => "1").should == {:path =>"/usuarios/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "usuarios", :action => "destroy", :id => "1").should == {:path =>"/usuarios/1", :method => :delete}
    end

    it 'maps #password' do
      route_for(:controller => "usuarios", :action => "password", :id => "1").should == {:path =>"/usuarios/1/password", :method => :get}
    end

    it 'maps #password_update' do
      route_for(:controller => "usuarios", :action => "password_update", :id => "1").should == {:path =>"/usuarios/1/password_update", :method => :put}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/usuarios").should == {:controller => "usuarios", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/usuarios/new").should == {:controller => "usuarios", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/usuarios").should == {:controller => "usuarios", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/usuarios/1").should == {:controller => "usuarios", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/usuarios/1/edit").should == {:controller => "usuarios", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/usuarios/1").should == {:controller => "usuarios", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/usuarios/1").should == {:controller => "usuarios", :action => "destroy", :id => "1"}
    end

    it 'generacion de parametros #password' do
      params_from(:get, "/usuarios/1/password").should == {:controller => "usuarios", :action => "password", :id => "1"}
    end

    it 'generacion de parametros #password_update' do
      params_from(:put, "/usuarios/1/password_update").should == {:controller => "usuarios", :action => "password_update", :id => "1"}
    end
  end
end
