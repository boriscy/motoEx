# Clase principal que reqliza la importacion de datos
class Importar
  attr_reader :celda_inicial, :celda_final
  
  # id del area que se desea importar
  def initialize(area)
    @aera = Area.find(area)
    @area_general = AreaGenral.new(@area.celda_inicial, @aera.celda_final)
    

  end
end

#
#class AreaGenral < AreaImp
#  attr_accessor :titular, :encabezado, :descadas, :fin
#
#  def intialize(area)
#    super(area)
#    @fija = area.fija
#    @iterar_fila = area.iterar_fila
#    @nombre = area.nombre
#    @rango = area.rango
#    
#    # Partes del area
#    @titular = Titular.new(area.titular)
#    @encabezado = Encabezado.new(area.encabezado)
#    @fin = Fin.new(area.fin)
#
#    @descartartadas = {}
#    area.each{|k, v| @descartartadas[k] = Descartar.new(v)}
#  end
#
#end
#
#class Titular < AreaImp
#  attr_accessor :celdas
#
#  def initialize(area)
#    super(area)
#    @celdas = area['celdas']
#  end
#end
#
#class AreaEsp < AreaImpç
#  attr_accessor :celdas, :campos
#
#  def intialize(area)
#    super(area)
#    @celdas = []
#    area['celdas']
#  end
#end
#
#class Encabezado < AreaImp
#  attr_accessor :celdas, :campos
#
#  def initialize(area)
#    super(area)
#    @celdas = []
#    area['celdas'].each do |v|
#      @celdas = area['celdas']
#    end
#
#    @campos = area['campos']
#  end
#end
#
#class Descartar < AreaPrin
#  attr_accessor :celdas
#
#  def initialize(area)
#    super(area)
#    #@celdas = area['celdas']
#    @patron = area['patron']
#    @excepciones = area['excepciones']
#  end
#end
#
#
#
#class Fin < AreaImp
#  attr_accessor :celdas
#
#  def initialize(area)
#    super(area)
#    @celdas = area['celdas']
#  end
#end
