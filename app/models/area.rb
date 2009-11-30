class Area < ActiveRecord::Base


  belongs_to :hoja

  # Para poder listar filas o columnas
  FILAS = [["Filas", true], ["Columnas", false]]

  serialize :encabezado
  serialize :fin
  serialize :no_importar
  serialize :titular

#  [:celda_inicial, :celda_final, :celdas].each do |m|
#    attr_accessor "encabezado_#{m}".to_sym
#    attr_accessor "fin_#{m}".to_sym
#  end
#  attr_accessor :excluida

#  composed_of :encabezado, :class_name => "Encabezado", 
#    :mapping => [[:encabezado_celda_inicial, :celda_inicial], [:encabezado_celda_final, :celda_final]]
#  serialize :encabezado
#  serialize :titular
#  serialize :fin
#  serialize :no_importar
  validates_presence_of :nombre#, :celda_inicial, :celda_final
  validates_numericality_of :rango

  # Presenta la celda en formato excel
  def formato_excel(celda)
    if self.send(celda).nil?
      "&nbsp;"
    else
      sp = self.send(celda).split("_")
      %(#{sp[1].to_i.excel_col} #{sp[0]})
    end
  end

end
