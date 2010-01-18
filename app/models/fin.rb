class Fin < AreaEsp

  # Indica si es el fin de la iteracion
  #   @param Integer pos
  #   @return Boolean
  def fin?(pos)
    campos.each do |k, v|
      fila, columna = asignar_posicion(k, pos)
      return false unless v['texto'] == hoja_electronica.cell(fila, columna).to_s.strip
    end
    true
  end

end
