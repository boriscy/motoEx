# almacena todas las areas descartadas
class Descartar < AreaEsp
  attr_accessor :descartadas_patron, :descartadas_posicion

  # Constructor
  # @param Hash descartadas
  def inicialize(area, hoja_electronica, iterar_filas = true)
    super(area, hoja_electronica, iterar_filas)

    area.each do |k, v|
      if v.keys > 0
        descartadas_patron[k]['patrones'] = v['exepciones']
        v.delete('exceptiones')
        v.each{|po, val| descartadas_patron[k]['patrones'][k] = val }
      else
        v.delete('exceptiones')
        v.each{|po, val| descartadas_patron[k]['patrones'][k] = val }
      end
    end
  end
end
