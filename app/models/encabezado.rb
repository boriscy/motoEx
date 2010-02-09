# Clase que maneja los encabezados, que támbien retorna el contenido de una fila
# o columna dependiendo si se itera fila o columna
# el encabezado puedes estar compuesto de celdas o campos, los campos son en realidad
# los datos que se extraerá del archivo a importar
#   Encabezado.new({
#     'campos' =>
#       {"5_5"=>{"campo"=>"gsa", "texto"=>"GSA"}, "5_6"=>{"campo"=>"mercado_interno", "texto"=>"MERCADO  INTERNO"}},
#     'celdas' =>
#       [{'texto' => 'DESTINO', 'pos' => '5_1'}, {'texto' => 'ARGENTINA', 'pos' => '5_2'}, {'texto' => 'BG COMGAS', 'pos' => '5_3'}]
#   }
class Encabezado <  AreaEsp
  attr_reader :proc_pos_enc, :proc_pos_fin

  # Se inicia los campos ademas de crear la posición de filas y columnas de los compos dependiendo si se itera filas o columnas
  # por <strong>ejemplo</strong> si se itera filas y tenemos
  #    { 'campos' => {"5_5"=>{"campo"=>"gsa", "texto"=>"GSA"},
  #    "5_6"=>{"campo"=>"argentina", "texto" => "ARGENTINA"} } }
  # Entonces una ves inicializado tendriamos
  #    { 'campos' => {"5_5"=>{"campo"=>"gsa", "texto"=>"GSA", "posicion" => 5}, 
  #    "5_6"=>{"campo"=>"argentina", "texto" => "ARGENTINA", "posicion" => 6} } }
  # Se almacena las columnas debido a que iteramos filas en caso de que se itere columnas se almacena la fila
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

  # Busca el encabezado de acuerdo al rango, en caso de que encuentra el patrón
  # retornado un array que indica cuanto se ha desplazado el encabezado en el archivo [desp_filas, desp_columnas]
  # sino encuentra el encabezado en los rangos retorna false
  #   @param [Fixnum] rango_filas
  #   @param [Fixnum] rango_columnas
  #   @return [Array, false]
  def buscar(rango_filas, rango_columnas)
    desp_filas, desp_columnas = [0, 0]

    # Retorna el desplazar si encontro todos los valores de la cabecera
    return [desp_filas, desp_columnas] if verificar_campos?(desp_filas, desp_columnas)
    # Iteración en el rango

    rango_filas, rango_columnas = crear_rango(rango_filas, rango_columnas)
    encontrado = false

    rango_filas.each do |i|

      rango_columnas.each do |j|
        if verificar_campos?(i, j)
          encontrado = true
          desp_filas, desp_columnas = i, j
          actualizar_posicion(desp_filas, desp_columnas)
          actualizar_posicion_encabezado()
          return [i, j]
        end
      end
    end

    false

  end

  # Extrae los datos indicados dependiendo la fila o columna
  #   @param Integer pos
  #   @return Hash
  def extraer_datos(pos)
    campos.inject({}) do |hash, v|
      fila, columna = proc_pos_enc.call(pos, v[1])
      hash[v[1]['campo']] = hoja_electronica.cell(fila, columna).to_s.strip
      hash
    end
  end

########################################
private

  # Verifica de que todas los campos en la fila o columna en que se encuentra el archivo
  # para comprobar si es que el patrón que marca el encabezado <strong>@campos</strong> es igual al del archivo
  #   @param [Fixnum] desp_filas # Indica cuanto se ha movido en filas
  #   @param [Fixnum] desp_columnas # Indica cuanto se ha movido en columnas
  #   @return [Boolean]
  def verificar_campos?(desp_filas, desp_columnas)
    @campos.each do |k ,v|
      fila, columna = k.split("_").map(&:to_i)
      fila, columna = [fila + desp_filas, columna + desp_columnas]
      return false unless v['texto'] == hoja_electronica.cell(fila, columna).to_s.gsub(/\n/," ")
    end

    true
  end

  # Crea un rango válido para poder verificar los valores
  #   @param [Integer] rango_filas
  #   @param [Integer] rango_columnas
  #   @return [Array] # Retorna un array con rangos Range [-2..3, -1..2]
  def crear_rango(rango_filas, rango_columnas)
    fila, columna = celda_inicial.split("_").map(&:to_i)
    fila_fin, columna_fin = celda_final.split("_").map(&:to_i)

    # Para definir inicios de fila y columna
    if rango_filas > fila
      ini_fila = 1 - fila
    else
      ini_fila = -rango_filas
    end

    if rango_columnas > columna
      ini_columna = 1 - columna
    else
      ini_columna = -rango_columnas
    end

    # Para que itere máximo hasta la ultima fila de la hoja electronica
    if (fila_fin + rango_filas) > hoja_electronica.last_row
      rango_filas = hoja_electronica.last_row - fila_fin
    end

    if (columna_fin + rango_columnas) > hoja_electronica.last_column
      rango_columnas = hoja_electronica.last_column - columna_fin
    end

    [ini_fila..rango_filas, ini_columna..rango_columnas]

  end

  # Actualiza las posiciones de los campos, estas posiciones son datos extra que 
  # se genera para cuando se crea el campo para saber la columna o fila en la cual se encuentra
  # por <strong>ejemplo</strong> si tenemos despues de haber actualizado los encabezados "actualizar_posición"
  #    { 'campos' => {"5_7"=>{"campo"=>"gsa", "texto"=>"GSA", "posicion" => 5}, 
  #    "5_8"=>{"campo"=>"argentina", "texto" => "ARGENTINA", "posicion" => 6} } }
  # despues de pasar por esta función tendriamos
  #    { 'campos' => {"5_7"=>{"campo"=>"gsa", "texto"=>"GSA", "posicion" => 7}, 
  #    "5_8"=>{"campo"=>"argentina", "texto" => "ARGENTINA", "posicion" => 8} } }
  #
  def actualizar_posicion_encabezado
    fila_col = 1
    fila_col = 0 unless iterar_fila?
    @campos.each do |k, v|
      pos = k.split("_").map(&:to_i)
      v['posicion'] = pos[fila_col]
    end
  end

end
