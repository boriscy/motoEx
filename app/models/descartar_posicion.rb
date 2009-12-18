# almacena todas las areas descartadas
class DescartarPosicion < AreaEsp
  attr_reader :descartada

  # Constructor
  # @param Hash descartadas
  def initialize(area, hoja_electronica, iterar_fila = true)
    super(area, hoja_electronica, iterar_fila)
    # Indica si ya fue descartada
    @descartada = false
  end

end
