# Area pricnipal encargada de manejar todas las subareas
class AreaGeneral < AreaImp

  attr_reader :titular, :encabezado, :descartadas_posicion, :descartadas_patron#, :fin
  attr_accessor :rango, :nombre, :iterar_fila

  # Constructor
  # @param area
  def initialize(area, hoja_electronica)
    super(area)

    # Parametros
    @rango = area['rango'].to_i
    @nombre = area['nombre']
    @iterar_fila = area['iterar_fila'] == true
    @hoja_electronica = hoja_electronica

    # Componentes
    @titular = Titular.new(area['titular'], hoja_electronica)
    @encabezado = Encabezado.new(area['encabezado'], hoja_electronica)
    #@fin = area['fin']
    # Asigna las areas descartadas
    asignar_areas_descartadas(area['descartar'])

    desplazar = @encabezado.buscar_inicio(@hoja_electronica)

    if desplazar > 0
      [@titular, @areas].each{|v| v.send(:actualizar_posicion, desplazar)
    end
  end

private

  # Se asignan las areas descartadas de acuerdo a su posicion
  # o de acuerdo a su patron
  # @param Hash areas
  def asignar_areas_descartadas(areas)
    areas.each do |k, v|
      if v['patron'].keys > 0
        @descartadas_patron[k] = Descartar.new(v, @hoja_electronica, true)
      else
        @descartadas_posicion[k] = Descartar.new(v, @hoja_electronica, false)
      end
    end
  end

end
