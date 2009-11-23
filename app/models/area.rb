class Area < ActiveRecord::Base
  belongs_to :hoja

  [:celda_inicial, :celda_final, :celdas].each do |m|
    attr_accessor "enc_#{m}".to_sym
  end
  attr_accessor :excluida

  composed_of :encabezado, :class_name => "Encabezado", 
    :mapping => [[:enc_celda_inicial, :celda_inicial], [:enc_celda_final, :celda_final]]
#  serialize :encabezado
#  serialize :titular
#  serialize :fin
#  serialize :no_importar
end
