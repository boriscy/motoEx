# Clase que maneja los encabezados
class Encabezado <  AreaEsp

  # Busca el encabezado de acuerdo al rango, en caso de que encuentra el patron
  # en el cual se encuentra el encabezado retorna un numero de lo contrario retorna false
  # @param Fixnum rango
  # @return Fixnum || False
  def buscar(rango)
    desplazar = 0

    # Retorna el desplazar si encontro todos los valores de la cabecera
    return desplazar if verificar_campos(desplazar)
    # Iteración en el rango
    #desplazar = false

    arr = crear_rango(rango)

    arr.each do |v|
      next if (fila_inicial + v) < 0

      if verificar_campos(v)
        desplazar = v
        actualizar_posicion(desplazar)
        break
      end
    end

    desplazar
  end

private
  # Verifica de que todas las celdas, comparando las posiciones de los campos en la
  # clase Encabezado con los valores de la hoja_electronica
  # @param Fixnum pos # Indica cuanto se ha movido en filas o columnas el encabezado
  def verificar_campos(pos)
    valido = true
  
    @campos.each do |k ,v|
      fila, columna = k.split("_").map(&:to_i)
      if iterar_fila
        valido = false unless v['texto'] == hoja_electronica.cell(fila + pos, columna)
        break
      else
        valido = false unless v['texto'] == hoja_electronica.cell(fila, columna + pos)
        break
      end
    end
    valido
  end

  # Crea un rango válido para poder verificar los valores
  # @param Integer rango
  # @return Array
  def crear_rango(rango)
    fila, columna = celda_inicial.split("_").map(&:to_i)
    if iterar_fila
      ini = (rango >= fila) ? 1 : fila - rango
    else
      ini = (rango >= columna) ? 1 : fila - rango
    end
    fin = fila + rango

    r = (ini..fin).to_a.select{|v| v != 0}
  end

end
