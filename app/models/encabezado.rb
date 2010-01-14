# Clase que maneja los encabezados
class Encabezado <  AreaEsp
  attr_reader :proc_pos_enc, :proc_pos_fin

  def initialize(area, hoja_electronica, iterar_fila_tmp=true)
    super(area, hoja_electronica, iterar_fila_tmp)    
    # Asignacion de posicion, para determinar si es columna fija o 
    @campos = campos.inject({}) do |hash, v|
      fila, columna = v[0].split("_").map(&:to_i)
      if iterar_fila?
        hash[ v[0] ] = v[1].merge({'posicion' => columna})
        # Se define el proc para poder acceder a la posicion del encabezado
        @proc_pos_enc = lambda{|pos, campo| [pos, campo['posicion'] ]}
        @proc_pos_fin = lambda{ fila_final }
      else
        hash[ v[0] ] = v[1].merge({'posicion' => fila})
        # Se define el proc para poder acceder a la posicion del encabezado
        @proc_pos_enc = lambda{|pos, campo| [campo['posicion'], pos ]}
        @proc_pos_fin = lambda{ columna_final }
      end
      hash
    end
  end

  # Busca el encabezado de acuerdo al rango, en caso de que encuentra el patron
  # en el cual se encuentra el encabezado retorna un numero de lo contrario retorna false
  # @param Fixnum rango
  # @return Fixnum || False
  def buscar(rango)
    desplazar = 0

    # Retorna el desplazar si encontro todos los valores de la cabecera
    return desplazar if verificar_campos?(desplazar)
    # Iteración en el rango

    arr = crear_rango(rango)

    arr.each do |v|

      if verificar_campos?(v)
        desplazar = v
        actualizar_posicion(desplazar)
        break
      end
    end

    desplazar
  end

  # Extrae los datos indicados dependiendo la fila o columna
  # @param Integer pos
  # @return Hash
  def extraer_datos(pos)
    campos.inject({}) do |hash, v|
      fila, columna = proc_pos_enc.call(pos, v[1])
      hash[v[1]['campo']] = hoja_electronica.cell(fila, columna).to_s.strip
      hash
    end
  end

########################################
private

  # Verifica de que todas las celdas, comparando las posiciones de los campos en la
  # clase Encabezado con los valores de la hoja_electronica. Permitiendo reconocer 
  # si se encontro el encabezado en la hoja_electronica
  # @param Fixnum desp # Indica cuanto se ha movido en filas o columnas el encabezado
  # @return Boolean
  def verificar_campos?(desp)
    
    @campos.each do |k ,v|
      fila, columna = k.split("_").map(&:to_i)
      fila, columna = proc_desp.call(fila, columna, desp)
      
      return false unless v['texto'] == hoja_electronica.cell(fila, columna).to_s.gsub(/\n/," ")
    end

    true
  end

  # Crea un rango válido para poder verificar los valores
  # @param Integer rango
  # @return Array
  def crear_rango(rango)
    fila, columna = celda_inicial.split("_").map(&:to_i)
    if iterar_fila?
      ini = (rango >= fila) ? 1 : rango
    else
      ini = (rango >= columna) ? 1 : rango
    end

    r = (-ini..rango).to_a.select{|v| v != 0}
  end

end
