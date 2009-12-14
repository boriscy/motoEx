# Clase especial para pdoer inicializar con campos extra especiales
class AreaEsp < AreaImp

    attr_accessor :celdas, :campos

    # Solo almacena en celdass aquellas que tienen un valor
    def initialize(area)
      super(area)
      # Almacenar solo las celdas que tienen texto 
      @celdas = area['celdas'].inject([]){|h, v| h << v unless v['texto'].strip.blank?; h }
    end

end
