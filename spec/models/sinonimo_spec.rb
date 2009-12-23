require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sinonimo do
  before(:each) do
    archivo = File.join(RAILS_ROOT, 'ejemplos/campos_nombres.yml')

    @params = {
      :nombre_archivo => "partediario.xls",
      :mapeado => "nombre",
      :campo_id => "id",
      :archivo_tmp => ActionController::TestUploadedFile.new(archivo)
    }
  end

  it "debe subir el archivo" do
      Sinonimo.create!(@params)
  end

  it "debe parsear el dato correctamente" do
      @sinonimo = Sinonimo.create(@params)
      @sinonimo.mapeado['campos'].first.should == ''
  end

end
