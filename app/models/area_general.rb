class AreaGeneral < AreaImp

  attr_reader :titular, :encabezado, :descartadas, :fin
  attr_accessor :rango, :nombre, :iterar_fila

  def initialize(area)
    super(area)

    # Componentes
    @titular = area['titular']
    @encabezado = area['encabezado']
    @fin = area['fin']
    @descartadas = area['descartar']

    # Parametros
    @rango = area['rango'].to_i
    @nombre = area['nombre']
    @iterar_fila = area['iterar_fila'] == true
  end

end
