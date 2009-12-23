class Sinonimo < ActiveRecord::Base

  attr_accessor :archivo_tmp, :campo_id, :campo_nombre

  before_save :mapear_campo

  attr_protected :mapeado

  serialize :mapeado

  def to_s
    "#{nombre} (#{archivo})"
  end

  def mapear_campo
    arr = case( File.extname(archivo_tmp.original_filename).downcase)
    when '.yml' then parse_yaml()
    when '.xml' then parse_xml()
    when '.json' then parse_json()
    end
    debugger
    s = 0
  end

  def parse_yaml()
    yaml = YAML::parse( File.open(archivo_tmp.path) )
#    columns = yaml.transform['campos']['columns']
#    records =  yaml.transform['campos']['records']
#    lcol = lambda{|v, p| v[columns.find_index{|v| v==p}] }
#    debugger
#    records.inject([]){|s, v| s << { campo_id => lcol.call(v, campo_id), campo => lcol.call(v, campo) }; s  }
    yaml.transform
  end

  def self.yamel(param='nombre')
    yaml = YAML::parse( File.open( File.join( File.expand_path("~"), "campos.yml") ))
    columns = yaml.transform['campos']['columns']
    records =  yaml.transform['campos']['records']
    lcol = lambda{|v, p| v[columns.find_index{|v| v==p}] }
    records.inject([]){|s, v| s << { :id => lcol.call(v, 'id'), param.to_sym => lcol.call(v, param) }; s  }
  end

  # Parsea un documento xml que se sube al servidor
  def self.parse_xml(id, campo)

  end

  def self.parse_csv(id, campo)

  end

end
