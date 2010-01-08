class HojasController < ApplicationController

  before_filter :revisar_permiso
  # GET /hojas/1
  # GET /hojas/1.xml
  def hoja
    @hoja = Hoja.buscar_o_crear(params[:archivo_id], params[:numero])
  end
  
  def areas
    @hoja = Hoja.find_by_archivo_id_and_numero(params[:archivo_id], params[:numero])
  end

end
