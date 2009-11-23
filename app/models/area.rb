class Area < ActiveRecord::Base
  belongs_to :hoja

  [:celda_inicial, :celda_final, :celdas].each do |m|
    attr_accessor "encabezado_#{m}".to_sym
  end
  attr_accessor :excluida

  composed_of :encabezado, :class_name => "Encabezado", 
    :mapping => [[:encabezado_celda_inicial, :celda_inicial], [:encabezado_celda_final, :celda_final]]
#  serialize :encabezado
#  serialize :titular
#  serialize :fin
#  serialize :no_importar
  validates_presence_of :nombre, :celda_inicial, :celda_final
  validates_numericality_of :rango

end
