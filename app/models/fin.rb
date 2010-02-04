# Clase en la cual se guarda el patrón que debe buscar para determinar si es el fín de la iteración
class Fin < AreaEsp

  # Indica si es el fin de la iteracion, verificando de que se cumpla el patrón en la posición indicada
  #   @param [Integer] pos
  #   @return [true, false]
  def fin?(pos)
    campos.each do |k, v|
      fila, columna = asignar_posicion(k, pos)
      return false unless v['texto'] == hoja_electronica.cell(fila, columna).to_s.strip
    end
    true
  end

end
