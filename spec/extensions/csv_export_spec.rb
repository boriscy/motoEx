require 'rubygems'
require 'spec'
dir = File.expand_path(File.dirname(__FILE__) + "/../..")
required = "#{dir}/lib/class_extensions"

require required 

describe "Exportar csv" do
  before(:each) do
    @arr = []
    @arr << {'nombre' => 'Felix', 'apellido' => 'Carreño'}
    @arr << {'nombre' => 'Boris', 'apellido' => 'Barroso'}
  end

  it 'debe convertir correctamente' do
    arr = @arr.to_csv_hash
    arr = arr.split("\n")
    arr.first.should == "nombre,apellido"
    arr[1].should == "Felix,Carreño"
    arr[2].should == "Boris,Barroso"
  end

  it 'debe poder leer arrays' do
    @arr[0]['sinonimos_nombre'] = ['Fel', 'Gato Felix']
    @arr[1]['sinonimos_nombre'] = ['Bo']
    arr = @arr.to_csv_hash.split("\n")

    arr.first.should == "nombre,sinonimos_nombre,apellido"
    arr[1].should == 'Felix,"Fel,Gato Felix",Carreño'
    arr[2].should == 'Boris,"Bo",Barroso'
  end
end
