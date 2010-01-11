require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Importar do
  before(:each) do
    @params = {
      'archivo_tmp' => 'ejemplos/ParteDiario.xls',
      'archivo_nombre' => 'ParteDiario.xls',
      'areas' => ["1", "2"]
    }
   @usuario_mock = mock_model(Usuario, :id => 1, :nombre => 'Juan', :valid? => true)
    Usuario.stub!(:find).with(kind_of(Fixnum)).and_return(@usuario_mock)
    @us = Object
    @us.stub!(:record).and_return( @usuario_mock)
    UsuarioSession.stub!(:find).and_return(@us)

  end

  it 'debe crear una instancia' do
    Importar.create!(@params)
  end

  it 'debe asignar correctamente el usuario' do
    @importar = Importar.create!(@params)
    @importar.usuario_id.should == 1
  end

  it 'debe convertir en array si se le asigna un Hash a areas' do
    @params['areas'] = {'0' => '1', '2' => '2'}
    @importar = Importar.create!(@params)
    @importar.areas.class.to_s.should == 'Array'
  end

end
