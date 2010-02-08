# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsuariosController do

  before(:each) do
    @us = mock("record", :record => mock_model(Usuario, :id => 1, :nombre => 'Juan', :valid? => true))
    UsuarioSession.stub!(:find).and_return(@us)
  end

  def mock_usuario(stubs={})
    @mock_usuario ||= mock_model(Usuario, stubs)
  end


  describe "GET index" do
    it "assigns all usuarios as @usuarios" do
      Usuario.stub!(:all).and_return([mock_usuario])
      get :index
      assigns[:usuarios].should == [mock_usuario]
    end
  end

  describe "GET show" do
    it "assigns the requested usuario as @usuario" do
      Usuario.stub!(:find).with("37").and_return(mock_usuario)
      get :show, :id => "37"
      assigns[:usuario].should equal(mock_usuario)
    end
  end

  describe "GET new" do
    it "assigns a new usuario as @usuario" do
      Usuario.stub!(:new).and_return(mock_usuario)
      get :new
      assigns[:usuario].should equal(mock_usuario)
    end
  end

  describe "GET password" do
    before(:each) do
      @usuario_mock = ApplicationController.stub!(:current_user).and_return(mock_usuario( :id => 1 ) )
      Usuario.stub!(:find).with(1).and_return( @usuario_mock )
    end

    it 'debe asignar a @usuario con un usuario' do
      get :password, :id => "10"
      assigns[:usuario].should equal(@usuario_mock)
    end

  end

  describe "PUT password" do
    before(:each) do
      class Falso; end

      @usuario_mock = ApplicationController.stub!(:current_user).and_return(mock_usuario( :id => 1, :login => 'admin' ) )
      @usuario = {:password_old => 'demo123', :password => 'nuevopass', :password_confirmation => 'nuevopass'}

      Usuario.stub!(:find).with(1).and_return(@usuario_mock)
    end

    it 'debe poder actualizar correctamente' do
      debugger
      put :password_udpate, :id => 1, :usuario => @usuario
      response.should redirect_to(usuario_url(@usuario_mock))
    end

    it 'el flash[:notice] no debe estar vacio' do
      put :password_udpate, :id => 1, :usuario => @usuario
      flash[:notice].should_not == nil
    end

    it 'debe mostrar errores' do
      #put :password, :id => 1, :usuario => {:}
    end
  end
#
#  describe "GET edit" do
#    it "assigns the requested usuario as @usuario" do
#      Usuario.stub!(:find).with("37").and_return(mock_usuario)
#      get :edit, :id => "37"
#      assigns[:usuario].should equal(mock_usuario)
#    end
#  end
#
#  describe "POST create" do
#
#    describe "with valid params" do
#      it "assigns a newly created usuario as @usuario" do
#        Usuario.stub!(:new).with({'these' => 'params'}).and_return(mock_usuario(:save => true))
#        post :create, :usuario => {:these => 'params'}
#        assigns[:usuario].should equal(mock_usuario)
#      end
#
#      it "redirects to the created usuario" do
#        Usuario.stub!(:new).and_return(mock_usuario(:save => true))
#        post :create, :usuario => {}
#        response.should redirect_to(usuario_url(mock_usuario))
#      end
#    end
#
#    describe "with invalid params" do
#      it "assigns a newly created but unsaved usuario as @usuario" do
#        Usuario.stub!(:new).with({'these' => 'params'}).and_return(mock_usuario(:save => false))
#        post :create, :usuario => {:these => 'params'}
#        assigns[:usuario].should equal(mock_usuario)
#      end
#
#      it "re-renders the 'new' template" do
#        Usuario.stub!(:new).and_return(mock_usuario(:save => false))
#        post :create, :usuario => {}
#        response.should render_template('new')
#      end
#    end
#
#  end
#
#  describe "PUT update" do
#
#    describe "with valid params" do
#      it "updates the requested usuario" do
#        Usuario.should_receive(:find).with("37").and_return(mock_usuario)
#        mock_usuario.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, :id => "37", :usuario => {:these => 'params'}
#      end
#
#      it "assigns the requested usuario as @usuario" do
#        Usuario.stub!(:find).and_return(mock_usuario(:update_attributes => true))
#        put :update, :id => "1"
#        assigns[:usuario].should equal(mock_usuario)
#      end
#
#      it "redirects to the usuario" do
#        Usuario.stub!(:find).and_return(mock_usuario(:update_attributes => true))
#        put :update, :id => "1"
#        response.should redirect_to(usuario_url(mock_usuario))
#      end
#    end
#
#    describe "with invalid params" do
#      it "updates the requested usuario" do
#        Usuario.should_receive(:find).with("37").and_return(mock_usuario)
#        mock_usuario.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, :id => "37", :usuario => {:these => 'params'}
#      end
#
#      it "assigns the usuario as @usuario" do
#        Usuario.stub!(:find).and_return(mock_usuario(:update_attributes => false))
#        put :update, :id => "1"
#        assigns[:usuario].should equal(mock_usuario)
#      end
#
#      it "re-renders the 'edit' template" do
#        Usuario.stub!(:find).and_return(mock_usuario(:update_attributes => false))
#        put :update, :id => "1"
#        response.should render_template('edit')
#      end
#    end
#
#  end
#
#  describe "DELETE destroy" do
#    it "destroys the requested usuario" do
#      Usuario.should_receive(:find).with("37").and_return(mock_usuario)
#      mock_usuario.should_receive(:destroy)
#      delete :destroy, :id => "37"
#    end
#
#    it "redirects to the usuarios list" do
#      Usuario.stub!(:find).and_return(mock_usuario(:destroy => true))
#      delete :destroy, :id => "1"
#      response.should redirect_to(usuarios_url)
#    end
#  end

end
