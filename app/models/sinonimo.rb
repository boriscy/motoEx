class Sinonimo < ActiveRecord::Base

  before_save :mapear_campo, :unless => Proc.new{ |sinonimo| sinonimo.archivo_tmp.nil? }

  serialize :mapeado

  attr_protected :mapeado

  validates_presence_of :nombre
  
  validates_uniqueness_of :nombre
  
  validate :validar_archivo

  # No es necesaario crear attr_accessor para campos que existen el la Base de datos
  attr_accessor :archivo_tmp, :tipo, :separador

  TIPOS = [["CSV", "CSV"], ["JSON", "JSON"], ["XML", "XML"], ["YAML", "YAML"]]
  
  SEPARADORES = [["," , ","], [";" , ";"], [":" , ":"], ["{TAB}" , "{TAB}"]]

  def to_s
    nombre
  end

  # Realiza el mapeado de un archivo XML, YAML, JSON o CSV
  def mapear_campo()
    self.mapeado = case( File.extname(archivo_tmp.original_filename).downcase)
    when '.csv' then parsear_csv()
    when '.yml' then parsear_yaml()
    when '.xml' then parsear_xml()
    when '.json' then parsear_json()
    end
    archivo_tmp = nil
  end

  # Parseo de YAML
  def parsear_yaml()
    arr = YAML::parse( File.open(archivo_tmp.path) ).transform
    if arr.first.keys.first.is_a? Symbol
      arr.first.keys
    end
    arr
  end

  # Parseo de csv
  def parsear_csv()
    separador ||= ","
    csv = FasterCSV.read(archivo_tmp.path, :col_sep => separador)

    columnas = csv.shift
    columnas = columnas.inject({}){ |hash, k| hash[k] = columnas.index(k); hash }
    
    csv.inject([]) do |arr, valor| 
      arr <<  columnas.inject({}){ |hash, val|
        if val[0] =~ /^sinonimos_.*$/
          hash[val[0]] = []
          hash[val[0]] = valor[val[1]].split(",") unless valor[val[1]].nil?
        else
          hash[val[0]] = valor[val[1]]
        end
        hash
      }
    end

  end

  # Parseo de JSON
  def parsear_json()
    ActiveSupport::JSON.decode( File.open(archivo_tmp.path).inject(""){ |s, v| s << v } )
  end

  # Parseo XML
  def parsear_xml()
    xml = Nokogiri::XML(File.open(archivo_tmp.path))
    campos = []
    xml.css("record").first.traverse do |v|
      campos << v.name unless ['sinonimo', 'record'].include?(v.name) or v.class == Nokogiri::XML::Text
    end

    xml.css('record').inject([]) do |arr, nodo|
      arr << campos.inject({}) do |hash, campo|
        if campo =~ /^sinonimos_.+/
          hash[campo] = [] unless hash[campo]
          hash[campo] = nodo.css("#{campo} sinonimo").map(&:text)
        else
          hash[campo] = nodo.css(campo).text 
        end
        hash
      end
    end
  end
  
  def exportar_a_csv(agente = "linux")
    
    encoding = "utf-8"
    
    if agente =~ /^.*windows.*$/i
      encoding = "Windows-1252"
    end
    
    mapeado.to_csv_hash(",", encoding)
    
  end

private
  # Valida el archivo temporal
  def validar_archivo()
    if self.id.nil?
      add_archivo_tmp_error()
    elsif self.id and !archivo_tmp.nil?
      add_archivo_tmp_error()
    end
  end

  # Añade un error en caso de que el archivo tembporal Presente errores
  def add_archivo_tmp_error
    tipos = ["csv", "json", "xml", "yml", "yaml"]
    begin
      ext = File.extname(archivo_tmp.original_filename)[1,4]
      errors.add(:archivo_tmp, 'Debe seleccionar un archivo CSV, JSON, XML o YAML') unless tipos.include?(ext.downcase)
    rescue
      errors.add(:archivo_tmp, 'Debe seleccionar un archivo CSV, JSON, XML o YAML')
    end
  end

end
