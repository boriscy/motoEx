# Clase principal de la cual heredan todas las demas clases sus atributos y funciones,
# aqui se define las filas y columnas
class AreaImp

  attr_reader :celda_inicial, :celda_final, :hoja_electronica
  attr_reader :fila_inicial, :fila_final, :columna_inicial, :columna_final, :iterar_fila

  attr_reader :proc_pos, :proc_desp

  # Constructor
  # En caso de que itererar_filas = false # => Se itera las columnas
  #   @param Hash area
  #   @param Excel || Excelx || OpenOffice hoja_electronica
  #   @param Boolean iterar_fila
  def initialize(area, hoja_electronica, iterar_fila_tmp = true)
    @celda_inicial, @celda_final = area['celda_inicial'], area['celda_final']
    @iterar_fila = iterar_fila_tmp

    asignar_hoja_electronica(hoja_electronica)

    asignar_filas_columnas()
    # asigna un procedimiento para poder leer
    proc_posicion()
  end

  # Alias del iterar_fila
  def iterar_fila?
    iterar_fila
  end

  # Actualiza la posicion del area desplazandola dependiento si itera filas o columnas
  #   @param Integer desp_filas
  #   @param Integer desp_columnas
  def actualizar_posicion(desp_filas, desp_columnas)
    @fila_inicial += desp_filas
    @fila_final += desp_filas
    @columna_inicial += desp_columnas
    @columna_final += desp_columnas

    @celda_inicial = "#{@fila_inicial}_#{@columna_inicial}"
    @celda_final = "#{@fila_final}_#{@columna_final}"
  end

  # LLama directamente sin necesidad de indicar si itera filas o columnas
  #   @param String posicion
  #   @param Fixnum desp_filas
  #   @param Fixnum desp_columnas
  def crear_posicion_desplazada(posicion, desp_filas = 0, desp_columnas = 0)
    fila, columna = posicion.split("_").map(&:to_i)
    proc_desp.call(fila, columna, desp_filas, desp_columnas).join("_")
  end

  # crear una posicion en base a la fila y la columna
  #   @param String posicion
  #   @param Fixnum desplazar
  #   @param Bool self_iterar_fila
  def self.crear_posicion_desplazada( posicion, desplazar, self_iterar_fila )
    return posicion if desplazar == 0

    fila, columna = posicion.split("_").map(&:to_i)
    
    if self_iterar_fila
      posicion = "#{fila + desplazar}_#{columna}"
    else
      posicion = "#{fila}_#{columna + desplazar}"
    end

    posicion
  end

protected
  # Asigna la hoja electronica correcta
  def asignar_hoja_electronica(hoja_electronica)
    clases = [Excel, Excelx, Openoffice]
    raise "Error: AreaGeneral linea: #{__LINE__}, debe seleccionar un documento xls, xlsx o ods" unless clases.include?(hoja_electronica.class)
    @hoja_electronica = hoja_electronica
  end

  # Asigna las filas y columnas finales e iniciales
  def asignar_filas_columnas
    inicio = celda_inicial.split("_").map(&:to_i)
    fin = celda_final.split("_").map(&:to_i)
    @fila_inicial = inicio[0]
    @columna_inicial = inicio[1]
    @fila_final = fin[0]
    @columna_final = fin[1]
  end

  # Asigna la posicion de acuerdo a si se itera filas o columnas
  #   @param String posicion
  #   @param Integer pos # fila o columna en la cual se encuentra
  #   @return Array # Array de enteros con [fila, columna]
  def asignar_posicion(posicion, pos)
    fila, columna = posicion.split("_").map(&:to_i)
    @proc_pos.call(fila, columna, pos)
  end

  # Asigna procedimientos que sirven para poder obtner la posicion
  # para no tener que realizar "if iterar_fila?" cuando se itera
  def proc_posicion()
    if iterar_fila?
      @proc_pos = lambda{|fila, columna, pos| [pos, columna] }
    else
      @proc_pos = lambda{|fila, columna, pos| [fila, pos] }
    end
    @proc_desp = lambda{|fila, columna, desp_filas, desp_columnas| [(fila + desp_filas), (columna + desp_columnas)] }
  end

end
