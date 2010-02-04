# Area principal encargada de manejar todas las subareas como Titular, DescartarPatron, Encabezado
# y que permite interactuar a las mismas con el archivo y areas que se desea importar del archivo
class AreaGeneral < AreaImp

  attr_reader :titular, :encabezado, :fin, :descartadas_posicion, :descartadas_patron, :area_fija
  attr_accessor :rango_filas, :rango_columnas, :nombre
  attr_accessor :proc_condicion_iterar

  # Constructor que inicializa todas las areas y de en caso de que el archivo que se importa
  # tenga el area utiliada desplazada <strong>desplaza</strong> todas las areas relacionadas
  #   @param Hash area
  #   @param Excel, Excelx, Openoffice hoja_electronica # Hoja instanciada por Roo
  #   @param Boolean iterar_fila_tmp
  def initialize(area, hoja_electronica, iterar_fila_tmp = true)
    super(area, hoja_electronica, iterar_fila_tmp)

    # Parametros
    @rango_filas = area['rango_filas'].to_i
    @rango_columnas = area['rango_columnas'].to_i
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
    desplazar = @encabezado.buscar(self.rango_filas, self.rango_columnas)

    unless desplazar[0] == 0 and desplazar[1] == 0
      [self, @titular, @fin].select{|v| v unless v.nil? }.each do |v|
        v.send(:actualizar_posicion, desplazar[0], desplazar[1])
      end

      # Actualizacion de posiciones de areas de descarte
      actualizar_posiciones_descartar_patron(desplazar[0], desplazar[1]) if @descartadas_patron.size > 0
      actualizar_posiciones_descartar_posicion(desplazar[0], desplazar[1]) if @descartadas_posicion.size > 0
    end
  end

  # Realiza la lectura de un archivo excel una ves que se ha instanciado, devolviendo un Hash
  #   @return [Hash]
  def leer()
    arr = []
    condicion = crear_condicion_iterar()
    
    i = @encabezado.proc_pos_fin.call() + 1

    begin
      if descartadas_posicion[i]
        i += 1
        next
      end

      if descartar_por_patron?(i)
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


  # Crea un hash de posiciones dependiendo si se itera fila o columna
  # retornando un hash con las posiciones en las que hay descartados
  #   @param [String] incio
  #   @param [String] f # No se usa fin debido a que ya existe una metodo con ese nombre
  #   @return [Hash] # {12 => true, 20 => true}
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

  # Indica si es que hay algun patrón "descartadas_patron"
  #   @param [Integer] pos
  #   @return [true, false]
  def descartar_por_patron?(pos)
    descartadas_patron.each do |k, pat|
      return true if pat.valido?(pos)
    end

    false
  end

  # Crea la condicion que permite iterar a traves de las filas o columnas dependiendo que se itere
  #   @return [Proc]
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
  #   @param [Hash] areas
  def asignar_areas_descartadas_patron(areas)
    areas.each do |k, v|
      @descartadas_patron[k] = DescartarPatron.new(v, @hoja_electronica, true) if v['patron'].size > 0
    end
  end
 
  # Asigna las areas descartables por posicion, estas deben ser creadas
  # debido a que pueden ocupar mas de una fila si se itera filas
  #   @param [Hash] areas
  def asignar_areas_descartadas_posicion(areas)
    areas.each do |k, v|
      @descartadas_posicion.merge!(descartadas_posicion_rango(v['celda_inicial'], v['celda_final']) ) if v['patron'].size <= 0
    end
  end

  # Actualiza todas las posiciones de patrón según se haya desplazado la fila o columna
  #   @param [Integer] desp_fila
  #   @param [Integer] desp_columna
  def actualizar_posiciones_descartar_patron(desp_fila, desp_columna)
    descartadas_patron.each do |k, v|
      v.desplazar_patron(desp_fila, desp_columna)
    end
  end

  # Actualiza todas las posiciones de descarte por posicion si es que existen 
  # desplazamiento de filas o columnas en el archivo que se esta importando
  #   @param [Integer] desp_fila
  #   @param [Integer] desp_columna
  def actualizar_posiciones_descartar_posicion(desp_filas, desp_columnas)
    if iterar_fila?
      proc_descartadas_pos = lambda{|pos| pos + desp_filas }
    else
      proc_descartadas_pos = lambda{|pos| pos + desp_columnas }
    end

    @descartadas_posicion = descartadas_posicion.inject({}) do |hash, v|
      hash[proc_descartadas_pos.call(v[0])] = true
      hash
    end
  end
  
end
