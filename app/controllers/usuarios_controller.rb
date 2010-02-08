# coding: utf-8

class UsuariosController < ApplicationController
  before_filter :revisar_permiso
  before_filter :revisar_admin, :only => [:index, :destroy]


  # GET /usuarios
  # GET /usuarios.xml
  def index
    @usuarios = Usuario.all()

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.xml
  def show
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.xml
  def new
    @usuario = Usuario.new()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create
    params[:usuario].delete(:rol)
    @usuario = Usuario.new(params[:usuario])

    respond_to do |format|
      if @usuario.save
        flash[:notice] = 'El usuario fue creado correctamente.'
        format.html { redirect_to(@usuario) }
        format.xml  { render :xml => @usuario, :status => :created, :location => @usuario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
    params[:usuario].delete(:rol)
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        flash[:notice] = 'El usuario fue creado correctamente.'
        format.html { redirect_to(@usuario) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.xml
  def destroy
    @usuario = Usuario.find(params[:id])
    # Para no borrar el administrador
    if @usuario.rol == 'admin'
      raise "El usuario administrador no puede ser borrado"
    else
      @usuario.destroy

      respond_to do |format|
        format.html { redirect_to(usuarios_url) }
        format.xml  { head :ok }
        format.json { render :json => {:success => true}}
      end
    end
  end


  # GET /usuarios/1/password
  def password
    @usuario = Usuario.find(current_user.id)
  end

  # PUT /usuarios/1/password
  def password_update
    @usuario = Usuario.find(current_user.id)
    usuario = params[:usuario]
    valido = UsuarioSession.new(:login => current_user.login, :password => usuario[:password_old]).valid?
    @usuario.errors.add(:password_old, "Contraseña incorrecta") unless valido

    respond_to do |format|
      if valido and @usuario.actualizar_password(usuario[:password], usuario[:password_confirmation])
        flash[:notice] = 'Su contraseña fue correctamente actualizada.'
        format.html { redirect_to(@usuario) }
        format.xml  { head :ok }
      else
        flash[:error] = 'No se pudo actualizar su contraseña.'
        format.html { render :action => "password" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end

  end

private
  def revisar_admin
    redirect_to(usuario_url(current_user.id) ) unless admin?
  end
end
