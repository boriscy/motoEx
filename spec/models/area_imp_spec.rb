require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AreaImp do

  before(:each) do
    @params = {
      'celda_inicial' => '1_2',
      'celda_final' => '3_4' 
    }
    @hoja_electronica = Object
    @hoja_electronica.stub!(:class).and_return(Excel)
  end

  it 'debe crear procs para iterar_fila' do
    @area_imp = AreaImp.new(@params, @hoja_electronica )
    @area_imp.proc_pos.class.to_s.should == "Proc"
    @area_imp.proc_desp.class.to_s.should == "Proc"
  end

  it "debe crear un area inicial con datos válidos" do
    @area_imp = AreaImp.new(@params, @hoja_electronica )

    @area_imp.celda_inicial.should == @params['celda_inicial']
    @area_imp.celda_final.should == @params['celda_final']

  end

  it "debe crear filas y columnas incial y final" do
    @area_imp = AreaImp.new(@params, @hoja_electronica)
  
    @area_imp.fila_inicial.should == 1
    @area_imp.fila_final.should == 3
    @area_imp.columna_inicial.should == 2
    @area_imp.columna_final.should == 4

  end

  it "debe actualizar la posicion con positivos" do
    @params = {'celda_inicial' => "5_6", "celda_final" => "7_19"}
    @area_imp = AreaImp.new(@params, @hoja_electronica)

    @area_imp.actualizar_posicion(2, 3)
    @area_imp.celda_inicial.should == "7_9"
    @area_imp.celda_final.should == "9_22"

  end

  it "debe actualizar la posicion con negativos" do
    @params = {'celda_inicial' => "5_6", "celda_final" => "7_19"}
    @area_imp = AreaImp.new(@params, @hoja_electronica, false)

    @area_imp.actualizar_posicion(-4, -3)
    @area_imp.celda_inicial.should == "1_3"
    @area_imp.celda_final.should == "3_16"

  end

  describe "creacion de posicion" do

    it "desplazamiento" do
      # Positivo
      @area_imp = AreaImp.new(@params, @hoja_electronica, true)
      @area_imp.crear_posicion_desplazada('3_5', 2, 1).should == '5_6'
      # Negativo
      @area_imp = AreaImp.new(@params, @hoja_electronica, true)
      @area_imp.crear_posicion_desplazada('3_5', -2, -1).should == '1_4'
    end

  end

end
