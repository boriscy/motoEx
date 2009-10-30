class HojasController < ApplicationController
  # GET /hojas
  # GET /hojas.xml
  def index
    @hojas = Hoja.all
    #Archivo.last.hojas << Hoja.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hojas }
    end
  end

  # GET /hojas/1
  # GET /hojas/1.xml
  def show
    @hoja = Hoja.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hoja }
    end
  end

  # GET /hojas/new
  # GET /hojas/new.xml
  def new
    @hoja = Hoja.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hoja }
    end
  end

  # GET /hojas/1/edit
  def edit
    @hoja = Hoja.find(params[:id])
  end

  # POST /hojas
  # POST /hojas.xml
  def create
    @hoja = Hoja.new(params[:hoja])

    respond_to do |format|
      if @hoja.save
        flash[:notice] = 'Hoja was successfully created.'
        format.html { redirect_to(@hoja) }
        format.xml  { render :xml => @hoja, :status => :created, :location => @hoja }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hoja.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hojas/1
  # PUT /hojas/1.xml
  def update
    @hoja = Hoja.find(params[:id])

    respond_to do |format|
      if @hoja.update_attributes(params[:hoja])
        flash[:notice] = 'Hoja was successfully updated.'
        format.html { redirect_to(@hoja) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hoja.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hojas/1
  # DELETE /hojas/1.xml
  def destroy
    @hoja = Hoja.find(params[:id])
    @hoja.destroy

    respond_to do |format|
      format.html { redirect_to(hojas_url) }
      format.xml  { head :ok }
    end
  end
end
