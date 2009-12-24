class Sinonimo < ActiveRecord::Base

  attr_accessor :archivo_tmp, :campo_id, :campo_nombre

  before_save :mapear_campo

  attr_protected :mapeado

  serialize :mapeado

  def to_s
    "#{nombre} (#{archivo})"
  end

  # Realiza el mapeado de un archivo XML, YAML, JSON o CSV
  def mapear_campo
    self.mapeado = case( File.extname(archivo_tmp.original_filename).downcase)
    when '.yml' then parsear_yaml()
    when '.xml' then parsear_xml()
    when '.json' then parsear_json()
    end
  end

  # Parseo de YAML
  def parsear_yaml()
    YAML::parse( File.open(archivo_tmp.path) ).transform
  end

  # Parseo de JSON
  def parsear_json()
    ActiveSupport::JSON.decode( File.open(archivo_tmp.path).inject(""){|s, v| s << v} )
  end

  def parsear_xml()
    xml = Nokogiri::XML(File.open(archivo_tmp.path))
    campos = xml.css("record").first.css("*").inject([]){|s, v| s << v.name unless v.name =~ /sinonimo/; s}
    xml.css('record').inject([]) do |arr, nodo|
      arr << campos.inject({}){|hash, campo| 
        hash[campo.to_sym] = nodo.css(campo).text
        hash
      }.merge({:sinonimos => nodo.css("sinonimos").inject([]){|ar, sin| ar << sin.css("sinonimo").text} } )
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
