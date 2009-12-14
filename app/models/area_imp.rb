# Clase principal de la cial heredan todas las demas clases sus atributos
# 
class AreaImp

  attr_accessor :celda_inicial, :celda_final
  # Constructor
  # @param Hash area
  def initialize(area)
    @celda_inicial, @celda_final = area['celda_inicial'], area['celda_final']
  end
end
