require 'spec/mocks'

Factory.define :usuario do |u|
  u.nombre ""
  u.paterno "" 
  u.materno ""
  u.login
  u.password
  u.password_confirmation
  u.rol_id
  u.grupo_ids 
end


# Modulo principal para poder crear datos para las pruebas
module Soporte

  class << self

    # Metodo necesario para poder acelerar el proceso de creación en caso de que
    # no se necesite la creacion de hojas html en el modelo Hoja
    def stub_crear_hoja_html()
      Hoja.stub!(:crear_hoja_html)
    end

    # devulve el path por defecto donde se encuentra un archvo
    #   @param Array args
    def path(*args)
      File.join(RAILS_ROOT, "ejemplos", args)
    end

    # Crea un usuario válido
    def crear_usuario
      @usuario = Usuario.create(:nombre => 'admin', :paterno => 'test', :materno => 'soporte', :login => 'admin', 
                                :email => 'admin@example.com', :password => 'demo123', :password_confirmation => 'demo123')
    end

    # Crea una instancia a leer para la archivo electronica
    #   @param Tmpfile archivo
    def hoja_electronica(archivo)
      case File.extname(archivo).downcase
        when ".xls" then Excel.new(path(archivo))
        when ".xlsx" then Excelx.new(path(archivo))
        when ".ods" then Openoffice.new(path(archivo))
      end
    end

    # Stub que permite crear el archivo y simular que obtiene el usuario que creo el archivo
    def stub_usuario_session
      unless @usuario.nil?
        @us = Object
        @us.stub!(:record).and_return( @usuario)
        UsuarioSession.stub!(:find).and_return(@us)
      else
        raise "Debe crear un usuario"
      end
    end
    
    def crear_archivo_temporal(archivo)
      ActionController::TestUploadedFile.new( path(archivo) , 'application/vnd.ms-excel')
    end


    # Crea un archivo con el archivo excel y el archivo yaml que se le indique
    #   @param String archivo_xls
    #   @param String archivo yaml # Archivo con el area
    def crear_archivo_test(archivo_xls, archivo_yaml = "")
      if archivo_yaml.blank?
        archivo_yaml = path('areas', archivo.gsub( File.extname(archivo), ".yml") )
      else
        archivo_yaml = path('areas', archivo_yaml)
      end

      archivo_tmp = ActionController::TestUploadedFile.new( path(archivo_xls) , 'application/vnd.ms-excel')
      # Creacion del Archivo y mock para que pueda almacenar
      stub_usuario_session()
      archivo = Archivo.create(:nombre => "Prueba1", :descripcion => "Comentarios", :archivo_excel => archivo_tmp)
      # Creacion de las hojas
      crear_archivo_hojas(archivo)

      # Relacion hoja y area
      data = YAML::parse(File.open( archivo_yaml ) ).transform
      raise "Debe definir su archivo YAML de area con el parametro \"hoja_numero\"" if data['area']['hoja_numero'].nil?
      hoja = Hoja.find_by_numero(data['area']['hoja_numero'])
      data['area'].delete('hoja_numero')
      # Crear Area
      data['area']['hoja_id'] = hoja.id
      Area.create(data['area'])
    end


    # Crea todos los datos necesarios para poder testear un archivo
    def crear_archivos
      Dir.glob( File.join(RAILS_ROOT, "ejemplos/*.xls") ).each_with_index do |a, i|
        params = {
          :nombre => "Archivo #{i + 1}", 
          :descripcion => "Prueba #{i + 1}",
          :archivo_excel => ActionController::TestUploadedFile.new(a, 'application/vnd.ms-excel')
        }
        Archivo.create!(params)
      end
    end

    # Crea las hojas de una hoja electronica
    #   @param Archivo archivo
    def crear_archivo_hojas(archivo)
      (Excel.new(archivo.archivo_excel.path) ).sheets.each_with_index do |h, i|
        archivo.hojas << Hoja.new(:numero => i, :nombre => h)
      end
    end

    # Crea harea para una hoja determinada
    def crear_areas(hoja)
      area = { :id => 1, :hoja_id => 10, 
      :nombre => "Mi salvada", :celda_inicial => "3_1", 
      :celda_final => "19_7", :rango => 5, :fija => false, 
      :iterar_fila => true, 
      :encabezado => 
        {"celdas"=>[{"texto"=>"DESTINO", "pos"=>"5_1"}, {
        "texto"=>"ARGENTINA", "pos"=>"5_2"}, 
        {"texto"=>"BG COMGAS", "pos"=>"5_3"}, 
        {"texto"=>"CUIABA", "pos"=>"5_4"}, 
        {"texto"=>"GSA", "pos"=>"5_5"}, 
        {"texto"=>"MERCADO \nINTERNO", "pos"=>"5_6"}, 
        {"texto"=>"TOTAL GN", "pos"=>"5_7"}, 
        {"texto"=>"(EN MMBTU)", "pos"=>"6_2"}],
        "campos"=>{"5_5"=>{"campo"=>"gsa", "texto"=>"GSA"},
        "5_1"=>{"campo"=>"destino", "texto"=>"DESTINO"},
        "5_3"=>{"campo"=>"bg", "texto"=>"BG COMGAS"}},
        "celda_final"=>"6_7", "celda_inicial"=>"5_1"},
        :fin => {"celdas"=>
        [{"texto"=>"TOTAL 2000", "pos"=>"0_19_1"},
          {"texto"=>"693,590.00", "pos"=>"0_19_2"}, 
          {"texto"=>"0.00", "pos"=>"0_19_3"},
          {"texto"=>"0.00", "pos"=>"0_19_4"},
          {"texto"=>"75,197,776.90", "pos"=>"0_19_5"},
          {"texto"=>"39,042,206.31", "pos"=>"0_19_6"},
          {"texto"=>"114,933,573.21", "pos"=>"0_19_7"}
        ], "campos"=>{"0_19_1"=>{"campo"=>"TOTAL 2000","texto"=>"TOTAL 2000"}}, 
        "celda_final"=>"19_7",
        "celda_inicial"=>"19_1"},
        :descartar => {"desc0"=>{"excepciones"=>[], "patron"=>{"2"=>{"texto"=>""}}, 
        "celda_final"=>"10_7", "celda_inicial"=>"10_1"}},
        :created_at => "2009-12-22 14:23:09", 
        :updated_at => "2009-12-22 14:23:09", 
        :titular => {"celdas"=>[{"texto"=>"VENTAS DE GAS NATURAL\nGESTIÓN 2000", "pos"=>"3_1"}], 
        "celda_final"=>"3_7", "celda_inicial"=>"3_1"}
    }
      area[:hoja_id] = hoja.id
      Area.create(area)
    end

  end
end
