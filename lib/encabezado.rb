class Encabezado
  attr_accessor :celda_inicial, :celda_final

  def initialize(ini, fin)
    @celda_inicial, @celda_final = ini, fin
  end
  
end
