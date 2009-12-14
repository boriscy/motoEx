# Clase que realiza la importación de archivos de
# acuerdo al patrón que se seleccione
class ImportarController < ApplicationController
  def index
    @archivos = Archivos.paginate(:page => @page)

    respond_to do |format|
      format.html
      format.xml {render :xml => @archivos}
    end
  end

  # Presenta un combo con el estado
  # archivo
  # hoja
  # area
  def view
    @archivo = Archivo.find(params[:id])
  end

  def new
    @archivo = Archivo.new

    respond_to do |format|
      format.html
      format.xml {render :xml => @archivo}
    end
  end

  def create

  end
end
