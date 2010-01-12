class ImportaresController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :validar_usuario

  def index
    @archivos = Archivo.paginate(:page => @page)

    respond_to do |format|
      format.html
      format.xml {render :xml => @archivos}
      format.json {render :text => @archivos.to_json}
    end
  end

  # Busca la hoja
  def show
    @hoja = Hoja.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render :xml => crear_array(@hoja) }
      format.json { render :json => crear_array(@hoja) }
      format.yaml { render :text => crear_array(@hoja).to_yaml, :content_type => 'text/yaml' }
    end
  end

  # Crea una nueva importacion
  def new
    @importar = Importar.new()

    respond_to do |format|
      format.html
      format.xml { render :xml => hash }
      format.json { render :json => @importar }
      format.yaml { render :yaml => @importar }
    end
  end

  def create
    @importar = Importar.new(params[:importar])
    params[:importar].delete(:archivo_tmp) # Problemas al transformar a json

    if @importar.save
      respond_to do |format|
        format.html {render :text => 'JEJEJE'} #
        format.xml { render :xml => params }
        format.json { render :json => params }
        format.yaml { render :text => params.to_yaml }
      end
    else
      render :text => 'Error'
    end
  end

private
  # Crea un array para retornar un array especial en las listas
  # @param Hoja
  # @return Array
  def crear_array(hoja)
    hoja.areas.all(:select => "id, nombre")
  end
  
  # Verifica de que sea correcto el login y el password
  # @param String login
  # @param String password
  # @return Boolean
  def validar_usuario()
    u = UsuarioSession.new(:login => params[:login], :password => params[:password])
    redirect_to "/login" unless current_user unless u.save
  end
  
end
