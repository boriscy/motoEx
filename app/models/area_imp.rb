# Clase principal de la cial heredan todas las demas clases sus atributos
# aqui se defina las filas y columnas
class AreaImp

  attr_reader :celda_inicial, :celda_final, :hoja_electronica
  attr_reader :fila_inicial, :fila_final, :columna_inicial, :columna_final, :iterar_fila

  # Constructor
  # En caso de que itererar_filas = false # => Se itera las columnas
  # @param Hash area
  # @param Excel || Excelx || OpenOffice hoja_electronica
  # @param Boolean iterar_fila
  def initialize(area, hoja_electronica, iterar_fila_tmp = true)
    @celda_inicial, @celda_final = area['celda_inicial'], area['celda_final']
    @iterar_fila = iterar_fila_tmp

    asignar_hoja_electronica(hoja_electronica)

    asignar_filas_columnas()
  end

  # Alias del iterar_fila
  def iterar_fila?
    iterar_fila
  end

  # Actualiza la posicion del area desplazandola dependiento si itera filas o columnas
  # @param Fixnum desplazar
  def actualizar_posicion(desplazar)
    if @iterar_fila
      @fila_inicial += desplazar
      @fila_final += desplazar
    else
      @columna_inicial += desplazar
      @columna_final += desplazar
    end

    @celda_inicial = "#{@fila_inicial}_#{@columna_inicial}"
    @celda_final = "#{@fila_final}_#{@columna_final}"
  end

  # LLama directamente sin necesidad de indicar si itera filas o columnas
  # @param String posicion
  # @param Fixnum desplazar
  def crear_posicion_desplazada(posicion, desplazar = 0)
    self.class.crear_posicion_desplazada(posicion, desplazar, iterar_fila? )
  end

  # crear una posicion en base a la fila y la columna
  # @param String posicion
  # @param Fixnum desplazar
  # @param Bool self_iterar_fila
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

  def asignar_filas_columnas
    inicio = celda_inicial.split("_").map(&:to_i)
    fin = celda_final.split("_").map(&:to_i)
    @fila_inicial = inicio[0]
    @columna_inicial = inicio[1]
    @fila_final = fin[0]
    @columna_final = fin[1]
  end
  
end
