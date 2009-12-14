require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
#require File.expand_path(RAILS_ROOT + "/app/models/area_imp")

describe AreaImp do

  before(:each) do
    @params = {
      'celda_inicial' => '1_2',
      'celda_final' => '3_4'
    }
  end

  it "debe crear un area inicial con datos válidos" do
    @area_imp = AreaImp.new(@params)

    @area_imp.celda_inicial.should == @params['celda_inicial']
    @area_imp.celda_final.should == @params['celda_final']

  end
end
