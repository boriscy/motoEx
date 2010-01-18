# Clase especial para pdoer inicializar con campos extra especiales
class AreaEsp < AreaImp

  attr_reader :celdas, :campos

  # Solo almacena en celdass aquellas que tienen un valor
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
  def actualizar_posicion(desplazar)
    super(desplazar)
    actualizar_posicion_campos(desplazar)
    actualizar_posicion_celdas(desplazar)
  end

  # Actualiza la posicion para los campos o celdas
  # no es recomendable usar class << self para la creacion de este metodo
  #   @param string tipo # Parametros a que indica si se actualiza el campo o celda
  def actualizar_posicion_campos(desplazar)
    temp = {}

    campos.each do |k, v|
      temp[crear_posicion_desplazada(k, desplazar)] = v
    end
    @campos = temp
  end
  
  # Actualiza la posicion de las celdas acuerdo al desplazamiento que se pasa
  #   @param Integer desplazar
  def actualizar_posicion_celdas(desplazar)
    @celdas = celdas.map do |v|
      if v['pos']
        v['pos'] = crear_posicion_desplazada(v['pos'], desplazar)
      elsif v['posicion']
        v['posicion'] = crear_posicion_desplazada(v['posicion'], desplazar)
      end
      v
    end
  end

end
