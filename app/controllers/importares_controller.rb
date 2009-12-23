class ImportaresController < ApplicationController

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
    @archivo = Archivo.find(params[:id])
    @hojas = @archivo.hojas.all(:select => "id, nombre")
    @importar = Importar.new(:hoja_id => params[:hoja_id].to_i)
    @hoja = Hoja.new
    @hoja = Hoja.find(params[:hoja_id]) if params[:hoja_id]
    hash = {:importar => @importar, :archivo => @archivo, :hojas => @hojas}

    respond_to do |format|
      format.html
      format.xml { render :xml => hash }
      format.json { render :json => @importar }
      format.yaml { render :yaml => @importar }
    end
  end

  def create
    @importar = Importar.new()

    respond_to do |format|

    end
  end

private
  # Crea un array para retornar un array especial en las listas
  # @param Hoja
  # @return Array
  def crear_array(hoja)
    hoja.areas.all(:select => "id, nombre")
  end
  
end
