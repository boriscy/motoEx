class Sinonimo < ActiveRecord::Base

  attr_accessor :nombre, :mapeado
  attr_accessor :archivo_tmp, :tipo, :separador

  before_save :mapear_campo

  attr_protected :mapeado

  serialize :mapeado

  TIPOS = [["CSV", "CSV"], ["JSON", "JSON"], ["XML", "XML"], ["YAML", "YAML"]]
  
  SEPARADORES = [["," , ","], [";" , ";"], [":" , ":"], ["{TAB}" , "{TAB}"]]

  def to_s
    "#{nombre} (#{archivo})"
  end

  # Realiza el mapeado de un archivo XML, YAML, JSON o CSV
  def mapear_campo
    self.mapeado = case( File.extname(archivo_tmp.original_filename).downcase)
    when '.csv' then parsear_csv()
    when '.yml' then parsear_yaml()
    when '.xml' then parsear_xml()
    when '.json' then parsear_json()
    end
  end

  # Parseo de YAML
  def parsear_yaml()
    arr = YAML::parse( File.open(archivo_tmp.path) ).transform
    if arr.first.keys.first.is_a? Symbol
      arr.first.keys
    end
    arr
  end

  def parsear_csv(separador=",")
    csv = FasterCSV.read(archivo_tmp.path, :col_sep => separador)
    cols = {}; cols_sinonimos = {}
    columnas = csv.shift
    # Indices de columnas
    columnas.each_with_index do |v, k| 
      v = v.to_s
      if v =~ /^sinonimos_.+/
        cols_sinonimos[k] = v
      else
        cols[k] = v
      end
    end

    csv.inject([]) do |arr, valor| 
      arr <<  cols.inject({}){ |hash, val|
        hash[val[1]] = valor[val[0]]
        hash
      }.merge(cols_sinonimos.inject({}){ |hash, val| 
        hash[val[1]] = cols_sinonimos.map{ |v| valor[v[0]] }.compact
        hash
      })
    end

  end

  # Parseo de JSON
  def parsear_json()
    ActiveSupport::JSON.decode( File.open(archivo_tmp.path).inject(""){|s, v| s << v} )
  end

  def parsear_xml()
    xml = Nokogiri::XML(File.open(archivo_tmp.path))
    campos = []
    xml.css("record").first.traverse do |v|
      campos << v.name unless ['sinonimo', 'record'].include?(v.name) or v.class == Nokogiri::XML::Text
    end

    #sinonimos =  xml.css("record").first.css("*").inject([]){|s, v| s << v.name if v.name =~ /^sinonimos_.+/; s}
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

  def self.yamel(param='nombre')
    yaml = YAML::parse( File.open( File.join( File.expand_path("~"), "campos.yml") ))
    columns = yaml.transform['campos']['columns']
    records =  yaml.transform['campos']['records']
    lcol = lambda{|v, p| v[columns.find_index{|v| v==p}] }
    records.inject([]){|s, v| s << { :id => lcol.call(v, 'id'), param.to_sym => lcol.call(v, param) }; s  }
  end

end

#campos = Campo.all.inject([]){|s, v| 
#  s << {:id => v.id, :nombre => v.nombre, :codigo => v.codigo, :sinonimos => [{:sinonimo => v.nombre},{:sinonimo => v.sinonimo}]}
#  s
#}
# # f.class # => File
#f.inject(""){|s, v| s << v unless v =~ /^\s+<sinonimo>\n/ or v=~ /^\s+<\/sinonimo>\n/; s}
