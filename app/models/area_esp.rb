# Clase especial para pdoer inicializar con campos extra especiales
class AreaEsp < AreaImp

    attr_reader :celdas, :campos

    # Solo almacena en celdass aquellas que tienen un valor
    def initialize(area, hoja_electronica, iterar_filas=true)
      super(area, hoja_electronica, iterar_filas)
      # Almacenar solo las celdas que tienen texto 
      @celdas = area['celdas'].inject([]){|h, v| h << v unless v['texto'].strip.blank?; h }
      # campos seleccionados
      @campos = area['campos']
    end

    # Actualiza la posicion de los campos y llama a la funcion padre
    # @param Fixnum desplazar
    def actualizar_posicion(desplazar)
      super(desplazar)

      campos.each do |k, v|
        fila, columna = k.split("_").map(&:to_i)

        if iterar_filas
          llave = "#{fila + desplazar}_#{columna}"
        else
          llave = "#{fila}_#{columna + desplazar}"
        end
        @campos.delete(k)
        @campos[llave] = v
      end
    end

end
