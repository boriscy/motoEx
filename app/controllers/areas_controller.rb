class AreasController < ApplicationController
  # GET /areas
  # GET /areas.xml
  def index
    @areas = Area.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @areas }
    end
  end

  # GET /areas/1
  # GET /areas/1.xml
  def show
    @area = Area.find(params[:id])

    render :json => @area
  end

  # GET /areas/new
  # GET /areas/new.xml
  def new
    @area = Area.new(:iterar_fila => true, :rango => 5)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @area }
    end
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
  end

  # POST /areas
  # POST /areas.xml
  def create
    # Decodificacion de post que se hizo con JSON
    @area = Area.new(ActiveSupport::JSON.decode(params[:area]))
    #@area = Area.new(params[:area])

    if @area.save
      render :json => @area
    else
      render :json => @area.errors #, :status => :unprocessable_entity
    end
  end

  # PUT /areas/1
  # PUT /areas/1.xml
  def update
    @area = Area.find(params[:id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        flash[:notice] = 'Area was successfully updated.'
        format.html { redirect_to(@area) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @area.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.xml
  def destroy
    @area = Area.find(params[:id])
    @area.destroy

    respond_to do |format|
      format.html { redirect_to(areas_url) }
      format.xml  { head :ok }
    end
  end
end
