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
    @params[:separador] = ","
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

  it "debe presentar errores cuando un sinonimo es creado sin archivo" do
    set_archivo_tmp('yml')
    @params.delete(:archivo_tmp)
    @sinonimo = Sinonimo.create(@params)
    @sinonimo.errors[:archivo_tmp].should_not == nil
  end

  describe "edicion" do
    it "debe salvar sin modificar si es que no se envia el archivo" do
      set_archivo_tmp('yml')
      @sinonimo = Sinonimo.create(@params)
      @sinonimo = Sinonimo.last
      params2 = {:nombre => 'Nuevo nombre'}
      @sinonimo.update_attributes(params2)
      @sinonimo.save
      @sinonimo.nombre.should == params2[:nombre]
      @sinonimo.mapeado.first['nombre'].should == 'CASCABEL'
      @sinonimo.mapeado.last['nombre'].should == 'PALOMETA NW'
      @sinonimo.mapeado.first['sinonimos_nombre'].first.should == 'Casca'
    end
  end
  
  it "Debe exportar csv" do
    set_archivo_tmp('yml')
    @sinonimo = Sinonimo.create(@params)
    exportado = @sinonimo.exportar_a_csv().split("\n")
    campos = @sinonimo.mapeado.first.keys
    
    exportado.shift.should == campos.join(",")
    
    exportado.each_with_index do |v, k|
      (v + "\n").should == campos.inject([]) do |arr, i| 
        arr << ( i =~ /^sinonimos_.*$/ ? @sinonimo.mapeado[k][i].join(',').unpack('U*').pack('C*') : @sinonimo.mapeado[k][i].unpack('U*').pack('C*') )
      end.to_csv
    end
    
  end
  
end
