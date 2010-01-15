# Area pricnipal encargada de manejar todas las subareas
class AreaGeneral < AreaImp

  attr_reader :titular, :encabezado, :fin, :descartadas_posicion, :descartadas_patron, :area_fija
  attr_accessor :rango, :nombre
  attr_accessor :proc_condicion_iterar

  # Constructor
  # @param area
  def initialize(area, hoja_electronica, iterar_fila_tmp = true)
    super(area, hoja_electronica, iterar_fila_tmp)

    # Parametros
    @rango = area['rango'].to_i
    @nombre = area['nombre']
    @iterar_fila = iterar_fila
    @hoja_electronica = hoja_electronica
    @area_fija = area['fija']

    # Componentes
    @titular = Titular.new(area['titular'], hoja_electronica) if area['titular'].keys.size > 0
    @encabezado = Encabezado.new(area['encabezado'], hoja_electronica)
    # Asignar en caso de que no sea area['fija']
    @fin = Fin.new(area['fin'], @hoja_electronica) unless area_fija
    # Asigna las areas descartadas
    @descartadas_patron = {}
    @descartadas_posicion = {}
    asignar_areas_descartadas_patron(area['descartar'])
    asignar_areas_descartadas_posicion(area['descartar'])

    # busca el inicio del documento y desplaza la posición
    desplazar = @encabezado.buscar(self.rango)

    if desplazar > 0
      [self, @titular, @fin].select{|v| v unless v.nil? }.each{|v| v.send(:actualizar_posicion, desplazar) }
    end
  end

  # Realiza la lectura de un archivo excel una ves que se ha instanciado
  # @return arr
  def leer()
    arr = []
    condicion = crear_condicion_iterar()
    
    i = @encabezado.proc_pos_fin.call() + 1

    begin
      if descartadas_posicion[i]
        i += 1
        next
      end

      if descartar_posicion_patron?(i)
        i += 1
        next
      end

      arr << @encabezado.extraer_datos(i)
      i += 1
    end while !condicion.call(i)

    hash = {'datos' => arr}
    hash['titular'] = titular.obtener_titular if titular

    hash
  end

  # Actualiza la posicion del area descartada
  # @param Integer desplazar
  def actualizar_descartadas_posicion(desplazar)
    tmp = descartadas_patron
    @descartadas_posicion = descartadas_posicion.keys.inject({}){ |h, k| h[k + desplazar] = descartadas_posicion[k]; h }
  end

  # Crea un hash de posiciones dependiendo si se itera fila o columna
  # retornando un hash con las posiciones en las que hay descartados por posicion
  # @param String incio
  # @param String f # No se usa fin debido a que ya existe una metodo con ese nombre
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

private

  # Valida si es que hay algun patron "descartadas_patron"
  # @param Integer pos
  # @return Boolean
  def descartar_posicion_patron?(pos)
    descartadas_patron.each do |k, pat|
      return true if pat.valido?(pos)
    end

    false
  end

  # Crea la condicion que permite iterar
  # @reutrn Proc
  def crear_condicion_iterar()
    if area_fija
      if iterar_fila?
        return lambda{ |pos| fila_final == pos or hoja_electronica.last_row < pos }
      else
        return lambda{ |pos| columna_final == pos or hoja_electronica.last_column < pos }
      end
    else
      if iterar_fila?
        return lambda{ |pos| @fin.fin?(pos) or hoja_electronica.last_row < pos }
      else
        return lambda{ |pos| @fin.fin?(pos) or hoja_electronica.last_column < pos }
      end
    end
  end

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
  
end
