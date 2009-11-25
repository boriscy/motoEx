class ArchivosController < ApplicationController

  before_filter :revisar_permiso

  # GET /archivos
  # GET /archivos.xml
  def index
    @archivos = Archivo.paginate(:page => @page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @archivos }
    end
  end

  # GET /archivos/1
  # GET /archivos/1.xml
  def show
    @hoja = Hoja.buscar_o_crear(params[:id].to_i, 0)
    @archivo = @hoja.archivo
    @area = Area.new(:iterar_fila => true, :rango => 5)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @archivo }
    end
  end

  # GET /archivos/new
  # GET /archivos/new.xml
  def new
    @archivo = Archivo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @archivo }
    end
  end

  # GET /archivos/1/edit
  def edit
    @archivo = Archivo.find(params[:id])
  end

  # POST /archivos
  # POST /archivos.xml
  def create
    @archivo = Archivo.new(params[:archivo])

    respond_to do |format|
      if @archivo.save
        flash[:notice] = 'El Archivo fue creado.'
        format.html { redirect_to(@archivo) }
        format.xml  { render :xml => @archivo, :status => :created, :location => @archivo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @archivo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /archivos/1
  # PUT /archivos/1.xml
  def update
    @archivo = Archivo.find(params[:id])

    respond_to do |format|
      if @archivo.update_attributes(params[:archivo])
        flash[:notice] = 'Archivo was successfully updated.'
        format.html { redirect_to(@archivo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @archivo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /archivos/1
  # DELETE /archivos/1.xml
  def destroy 
    @archivo = Archivo.find(params[:id])
    @archivo.destroy

    respond_to do |format|
      format.html { redirect_to(archivos_url) }
      format.xml  { head :ok }
    end
  end
end
