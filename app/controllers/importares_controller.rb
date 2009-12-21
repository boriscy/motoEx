class ImportaresController < ApplicationController

  def index
    @archivos = Archivo.paginate(:page => @page)

    respond_to do |format|
      format.html
      format.xml {render :xml => @archivos}
    end
  end

  def show
    @hoja = Archivo.find(params[:id])

    respond_to do |format|
      format.html
      format.xml {render :xml => crear_array(@archivo)}
      format.json {render :json => crear_array(@archivo)}
      format.yaml {render :yaml => crear_array(@archivo)}
    end
  end

  # Crea una nueva importacion
  def new
    @archivo = Archivo.find(params[:id])
    @importar = Importar.new()

    respond_to do |format|
      format.html 
    end
  end

  def create

  end

private
  # Crea un array para retornar un array especial en las listas
  # @param Archivo
  # @return Array
  def crear_array(objeto)
    sym = objeto.is_a? Archivo ? :hoja : :area
    objeto.hojas.inject([]){|s, v| s << {sym => {:nombre => v.nombre, :id => v.id}}; s}
  end

  # Identifica el archivo y crea el select para renderearlo en linea
  def select(params)
    params[:objecto]
  end
  
end
