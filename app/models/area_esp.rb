# Clase especial para poder inicializar con campos extra especiales
class AreaEsp < AreaImp

  attr_reader :celdas, :campos

  # Solo se crean celdas o campos que tienen un valor
  def initialize(area, hoja_electronica, iterar_fila_tmp=true)
    super(area, hoja_electronica, iterar_fila_tmp)
    # Almacenar solo las celdas que tienen texto 
    if area['celdas']
      @celdas = area['celdas'].inject([]){|h, v|  h << v unless v['texto'].strip.blank?; h }
    else
      @celdas = []
    end
    # campos seleccionados
    @campos = area['campos']
  end

  # Actualiza la posicion de todos los elementos
  #   @param [Integer] desp_filas
  #   @param [Integer] desp_columnas
  def actualizar_posicion(desp_filas, desp_columnas)
    super(desp_filas, desp_columnas)
    actualizar_posicion_celdas(desp_filas, desp_columnas)
    actualizar_posicion_campos(desp_filas, desp_columnas) unless campos.nil?
  end

  # Actualiza la posicion para los campos o celdas
  # no es recomendable usar class << self para la creacion de este metodo
  #   @param Integer desp_filas
  #   @param Integer desp_columnas
  def actualizar_posicion_campos(desp_filas, desp_columnas)
    temp = {}

    campos.each do |k, v|
      temp[crear_posicion_desplazada(k, desp_filas, desp_columnas)] = v
    end
    @campos = temp
  end
  
  # Actualiza la posicion de las celdas acuerdo al desplazamiento que se pasa
  #   @param Integer desp_filas
  #   @param Integer desp_columnas
  def actualizar_posicion_celdas(desp_filas, desp_columnas)
    @celdas = celdas.map do |v|
      if v['pos']
        v['pos'] = crear_posicion_desplazada(v['pos'], desp_filas, desp_columnas)
      elsif v['posicion']
        v['posicion'] = crear_posicion_desplazada(v['posicion'], desp_filas, desp_columnas)
      end
      v
    end
  end

end
