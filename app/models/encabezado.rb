# Clase que maneja los encabezados
class Encabezado <  AreaEsp

  # Busca el encabezado de acuerdo al rango, en caso de que encuentra el patron
  # en el cual se encuentra el encabezado retorna un numero de lo contrario retorna false
  # @param Fixnum rango
  # @return Fixnum || False
  def buscar(rango)
    desplazar = 0

    # Retorna el offset si encontro todos los valores de la cabecera
    return desplazar if verificar_campos(offset)

    # Iteración en el rango
    desplazar = false

    arr = (-rango..rango).to_a
    arr.delete(0)

    arr.each do |v|
      next if (fila_inicial + v) < 0

      if verificar_campos(v)
        desplazar = v
        actualizar_posicion(v)
        break
      end
    end

    desplazar
  end

private
  # Verifica de que todas las celdas
  # @param Fixnum pos
  def verificar_campos(pos)
    valido = true
  
    @campos.each do |k ,v|
      fila, columna = k.split("_").map(&:to_i)
      if @iterar_filas
        valido = false unless v['texto'] == hoja_electronica.cell(fila + pos, columna)
        break
      else
        valido = false unless v['texto'] == hoja_electronica.cell(fila, columna + pos)
        break
      end
    end
    valido
  end

end
