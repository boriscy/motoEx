class SinonimosController < ApplicationController


  # GET /sinonimos
  # GET /sinonimos.xml
  def index
    @sinonimos = Sinonimo.all(:select => "id, nombre" )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sinonimos }
      format.json  { render :json => @sinonimos }
    end
  end

  # GET /sinonimos/1
  # GET /sinonimos/1.xml
  def show
    @sinonimo = Sinonimo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sinonimo }
      format.json  { render :json => @sinonimo }
      format.csv {render :text => @sinonimo.exportar_a_csv(request.user_agent)}
    end
  end

  # GET /sinonimos/new
  # GET /sinonimos/new.xml
  def new
    @sinonimo = Sinonimo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sinonimo }
    end
  end

  # GET /sinonimos/1/edit
  def edit
    @sinonimo = Sinonimo.find(params[:id])
  end

  # POST /sinonimos
  # POST /sinonimos.xml
  def create
    @sinonimo = Sinonimo.new(params[:sinonimo])

    if @sinonimo.save
      render :text => @sinonimo.to_json
    else
      render :text => @sinonimo.errors.to_json, :status => :unprocessable_entity
    end

#    respond_to do |format|
#      if @sinonimo.save
#        flash[:notice] = 'Sinonimo was successfully created.'
#        format.html { redirect_to(@sinonimo) }
#        format.xml  { render :xml => @sinonimo, :status => :created, :location => @sinonimo }
#        format.json {  }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @sinonimo.errors, :status => :unprocessable_entity }
#      end
#    end
  end

  # PUT /sinonimos/1
  # PUT /sinonimos/1.xml
  def update
    @sinonimo = Sinonimo.find(params[:id])

    #respond_to do |format|
      if @sinonimo.update_attributes(params[:sinonimo])
        render :text => @sinonimo.to_json
        #flash[:notice] = 'Sinonimo was successfully updated.'
        #format.html { redirect_to(@sinonimo) }
        #format.xml  { head :ok }
      else
        render :text => @sinonimo.errors.to_json, :status => :unprocessable_entity
        #format.html { render :action => "edit" }
        #format.xml  { render :xml => @sinonimo.errors, :status => :unprocessable_entity }
      end
    #end
  end

  # DELETE /sinonimos/1
  # DELETE /sinonimos/1.xml
  def destroy
    @sinonimo = Sinonimo.find(params[:id])
    @sinonimo.destroy

    respond_to do |format|
      format.html { redirect_to(sinonimos_url) }
      format.xml  { head :ok }
    end
  end
end
