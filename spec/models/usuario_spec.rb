# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Usuario do

  it {should validate_presence_of(:nombre) }
  it {should have_many(:archivos) }

  describe "Valido" do
    
    before(:each) do
      @valid_attributes = {
        :nombre => "Juan",
        :paterno => "Perez ",
        :materno => " Lopez",
        :email => "juan@example.com",
        :rol => "admin",
        :login => "juan",
        :password => "juanito16",
        :password_confirmation => "juanito16"
      }

      do_create
    end

    def do_create
      @usuario = Usuario.create(@valid_attributes)
      debugger
      s=0
    end

    it "debe tener nombre_completo()" do
      nombre_completo = "#{@valid_attributes[:nombre]} #{@valid_attributes[:paterno]} #{@valid_attributes[:materno]}"
      @usuario.nombre_completo.should == nombre_completo.squish
    end

    it "debe tener to_s() igual a nombre_completo" do
      @usuario.to_s.should == @usuario.nombre_completo
    end

    it "debe limpiar :nombre, :paterno, :materno squish_params()" do
      [:nombre, :paterno, :materno].each do |v|
        @usuario.send(v).should == @valid_attributes[v].squish
      end
    end

    it 'debe actualizar password' do
      @usuario.actualizar_password('prueba1', 'prueba1').should == true
    end

    it 'no debe actualizar password con parametros errados' do
      @usuario.actualizar_password('prueba1', 'prueba2').should == false
    end

    it "debe presentar tipo correctamente" do
      do_create
      @usuario.ver_tipo.should == "Administrador"
    end

  end
  
 # describe "Invalido" do
 #   before do
 #     @invalid_attributes = {
 #       :nombre => "Juan 1",
 #       :paterno => "Perez -_",
 #       :materno => " Lopez -_",
 #       :email => "juan@example.com",
 #       :login => "juan s",
 #       :password => "ju",
 #       :password_confirmation => "ju",
 #       :tipo => 'admin'
 #     }

 #   end

 #   def do_create
 #     @usuario = Usuario.create(@invalid_attributes)
 #   end

 #   it "debe mostrar login invalido" do
 #     do_create
 #     @usuario.errors[:login].should == I18n.t("authlogic.error_messages.login_invalid")
 #   end

 #   it "login debe ser entre 4..20 caracteres" do
 #     @invalid_attributes[:login] = "jua"
 #     do_create
 #     @usuario.errors[:login].should == I18n.t('activerecord.errors.messages.too_short', :count => 4)
 #     @usuario.login = "s" * 21
 #     @usuario.valid?
 #     @usuario.errors[:login].should == I18n.t('activerecord.errors.messages.too_long', :count => 20)
 #   end

 #   it "debe ser mas largo el password" do
 #     do_create
 #     @usuario.errors[:password].should_not == nil
 #   end
 # 
 # end

end

