class Titular < AreaEsp

  # Retorna los datos del titular uniendo todas las celdas que componen
  # este campo
  def obtener_titular
    celdas.each.map do |v| 

      fila, columna = v['pos'].split("_").map(&:to_i)
      @hoja_electronica.cell(fila, columna).to_s.strip
    end.join(" ")
  end
end
