# Clase que permite reconocer los patrones que son descartables por patron
# El patron debe tener las siguiente forma
# == Ejemplo:
#   # Se define la fila o columna dependiendo si se itera filas o columnas
#   @patron = {"1" => {'texto' => 'TOTAL'}, "5" => {'texto' => 'SUBTOTAL'}, 
#   # Se define la lista de excepciones
#     {"excepciones" => [[{'pos' => '1', 'texto' => 'MAYO '}]},
#     "celda_inicial" => "10_7", "" => "celda_final" => "10_1"
#   }
class DescartarPatron < AreaEsp
  attr_reader :patron, :excepciones, :proc_desc_pos

  def initialize(area, hoja_electronica, iterar_fila_tmp = true)
    super(area, hoja_electronica, iterar_fila_tmp)
    @patron = strip_texto_patron(area['patron'])
    @excepciones = area['excepciones'].map!{|v| strip_texto_excepciones(v) }
    if iterar_fila?
      @proc_desc_pos = lambda{|pos, pat| [pos, pat] }
    else
      @proc_desc_pos = lambda{|pos, pat| [pat, pos] }
    end
  end

  # Indica si el patron debe aplicarse para descartar la fila o columna
  #   @param Fixnum pos # Fila o columna a iterar
  def valido?(pos)
    verificar_patron?(pos) and !verificar_excepciones?(pos)
  end

  # Desplaza el patrón dependiendo si itera filas o columnas
  #   @param Integer desp_fila
  #   @param Integer desp_columna
  def desplazar_patron(desp_fila, desp_columna)
    if iterar_fila?
      proc_desp_patron = lambda{|pos, fila, columna| pos + columna}
    else
      proc_desp_patron = lambda{|pos, fila, columna| pos + fila}
    end

    @patron = patron.inject({}) do |hash, v|
      pat_pos = proc_desp_patron.call(v[0].to_i, desp_fila, desp_columna)
      hash[pat_pos.to_s] = {'texto' => v[1]['texto']}
      hash
    end

    #################
    # NOTA es necesario cambiar las excepciones por que existe un array inecesario
    @excepciones = excepciones.inject([]) do |arr, v|
      arr << v.map do |val|
        nueva_pos = proc_desp_patron.call(val['pos'].to_i, desp_fila, desp_columna)
        {'pos' => nueva_pos, 'texto' => val['texto']}
      end
    end

  end

private
  # Verifica si se cumple el patron
  #   @param Integer pos
  #   @return Boolean
  def verificar_patron?(pos)
    patron.each do |k, v|
      fila, columna = proc_desc_pos.call(pos, k.to_i)
      return false unless hoja_electronica.cell(pos, k.to_i).to_s.strip == v['texto']
    end

    true
  end

  # Verifica si cumple una excepcion
  #   @param Integer pos
  #   @return Boolean
  def verificar_excepciones?(pos)
    return false if excepciones.size <= 0

    excepciones.each do |v|
      return true if verificar_grupo_excepciones?(v, pos)
    end

    false
  end

  # Verifica que todo un grupo de excepciones cumpla los valores
  #   @param Array grupo # Array con las excepciones de un grupo
  #   @param Integer pos
  #   @return [true, false]
  def verificar_grupo_excepciones?(grupo, pos)
    grupo.each do |v|
      fila, columna = proc_desc_pos.call(pos, v['pos'].to_i)
      return false unless hoja_electronica.cell(pos, v['pos'].to_i).to_s.strip == v['texto']
    end

    true
  end

  # Elimina los espacion en blanco del inicio y fin del texto en el patron
  # Muecho cuidado con los &nbsp; que pueden parecer espacio, son otro caracter
  #   @param Hash hash
  def strip_texto_patron(hash)
    hash.each do |k, v|
      # Experiemental
      v['texto'].strip! 
      # En caso de que sea un número decimal, 0.00 o 0.0000, Ruby reconocera 0.0
      if v['texto'] =~ /^\d+\.\d+$/
        v['texto'] = v['texto'].to_f.to_s
      end
    end
  end

  # Elimina los espacios al principio y al final del texto
  #   @param Array array
  def strip_texto_excepciones(array)
    array.each{|v| v['texto'].strip!}
  end


end
