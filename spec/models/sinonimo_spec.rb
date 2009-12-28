require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sinonimo do

  def set_archivo_tmp(ext = "yml")
    archivo = File.join(RAILS_ROOT, "ejemplos/map/campos.#{ext}")
    @params[:archivo_tmp] = ActionController::TestUploadedFile.new(archivo)
  end

  before(:each) do

    @params = {
      :nombre => "mapeado 1"
    }
    @sinonimo = nil
  end

  it "debe subir el archivo" do
    set_archivo_tmp()
    Sinonimo.create!(@params)
  end

  it "debe parsear el dato correctamente CSV" do
    set_archivo_tmp('csv')
    @sinonimo = Sinonimo.create(@params)
    @sinonimo.mapeado.first['nombre'].should == 'CASCABEL'
    @sinonimo.mapeado.last['nombre'].should == 'PALOMETA NW'
    @sinonimo.mapeado.first['sinonimos_nombre'].first.should == 'Casca'
  end

  it "debe parsear el dato correctamente YAML" do
    set_archivo_tmp('yml')
    @sinonimo = Sinonimo.create(@params)
    @sinonimo.mapeado.first['nombre'].should == 'CASCABEL'
    @sinonimo.mapeado.last['nombre'].should == 'PALOMETA NW'
    @sinonimo.mapeado.first['sinonimos_nombre'].first.should == 'Casca'
  end

  it "debe parsear el dato correctamente JSON" do
    set_archivo_tmp('json')
    @sinonimo = Sinonimo.create(@params)
    @sinonimo.mapeado.first['nombre'].should == 'CASCABEL'
    @sinonimo.mapeado.last['nombre'].should == 'PALOMETA NW'
    @sinonimo.mapeado.first['sinonimos_nombre'].first.should == 'Casca'
  end

  it "debe parsear el dato correctamente XML" do
    set_archivo_tmp('xml')
    @sinonimo = Sinonimo.create(@params)
    @sinonimo.mapeado.first['nombre'].should == 'CASCABEL'
    @sinonimo.mapeado.last['nombre'].should == 'PALOMETA NW'
    @sinonimo.mapeado.first['sinonimos_nombre'].first.should == 'Casca'
  end
end
