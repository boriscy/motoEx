class ImportaresController < ApplicationController

  def index
    @archivos = Archivo.paginate(:page => @page)

    respond_to do |format|
      format.html
      format.xml {render :xml => @archivos}
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
    @importar = Importar.new(:hoja_id => params[:hoja_id].to_i)

    respond_to do |format|
      format.html
      format.xml { remder :xml => @importar }
      format.json { remder :json => @importar }
      format.yaml { remder :yaml => @importar }
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
