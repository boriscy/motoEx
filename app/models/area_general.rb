# Area pricnipal encargada de manejar todas las subareas
class AreaGeneral < AreaImp

  attr_reader :titular, :encabezado, :fin, :descartadas_posicion, :descartadas_patron
  attr_accessor :rango, :nombre, :iterar_fila

  # Constructor
  # @param area
  def initialize(area, hoja_electronica, iterar_fila = true)
    super(area, hoja_electronica, iterar_fila)

    # Parametros
    @rango = area['rango'].to_i
    @nombre = area['nombre']
    @iterar_fila = iterar_fila
    @hoja_electronica = hoja_electronica

    # Componentes
    @titular = Titular.new(area['titular'], hoja_electronica)
    @encabezado = Encabezado.new(area['encabezado'], hoja_electronica)
  
    @fin = Fin.new() unless area['fija']
    #@fin = area['fin']
    # Asigna las areas descartadas
    @descartadas_patron = {}
    @descartadas_posicion = {}
    asignar_areas_descartadas_patron(area['descartar'])
    asignar_areas_descartadas_posicion(area['descartar'])

    # busca el inicio del documento y desplaza la posición
    desplazar = @encabezado.buscar_inicio(@hoja_electronica)

    if desplazar > 0
      [@titular, @areas].each{|v| v.send(:actualizar_posicion, desplazar)}
    end
  end

private

  # Se asignan las areas descartadas de acuerdo a su posicion
  # o de acuerdo a su patron
  # @param Hash areas
  def asignar_areas_descartadas_patron(areas)
    areas.each do |k, v|
      @descartadas_patron[k] = DescartarPatron.new(v, @hoja_electronica, true) if v['patron'].size > 0
    end
  end

  # Asigna las areas descartables por posicion, estas deben ser creadas
  # debido a que pueden ocupar mas de una fila si se itera filas
  def asignar_areas_descartadas_posicion(areas)
    areas.each do |k, v|
      @descartadas_posicion.merge!(descartadas_posicion_rango(v['celda_inicial'], v['celda_final']) ) if v['patron'].size <= 0
    end
  end

  # Crea un hash de posiciones dependiendo si se itera fila o columna
  # retornando un array hash con las posiciones en las que hay descartados por posicion
  # @param String incio
  # @param String f # No se usa fin debido a que ya existe una funcion con ese nombre
  # @return Hash
  def descartadas_posicion_rango(inicio, fin_pos)
    inicio = inicio.split("_").map(&:to_i)
    fin_pos = fin_pos.split("_").map(&:to_i)
    if iterar_fila?
      i, j = inicio[0], fin_pos[0]
    else
      i, j = inicio[1], fin_pos[1]
    end

    (i..j).inject({}){|s, v| s[v] = true; s}
  end

  # Actualiza la posicion del area descartada
  # @param 
  def actualizar_descartadas_posicion(desplazar)
    tmp = descartadas_patron
    descartadas_patron.each do |k, v|
      tmppos = k.split("_")
      if iterar_fila?
        
      else
      end
    end
  end

end
