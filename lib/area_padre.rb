# Clase principal de la cual heredan varias atributos otras clases realacionadas a 
# un area
class AreaPadre
  attr_accessor :celda_inicial, :celda_final

  def initialize(ini, fin)
    @celda_inicial, @celda_final = ini, fin
  end

end
