# Clase que permite reconocer los patrones que son descartables por patron
# El patron debe tener las siguiente forma
# == Ejemplo:
#   # Se define la fila o columna dependiendo si se itera filas o columnas
#   @patron = {"2" => {}, 
#   # Se define la lista de excepciones
#     {"excepciones" => [{'pos' => '1', 'texto' => 'MAYO '}]},
#     "celda_inicial" => "10_7", "" => "celda_final" => "10_1"
#   }
class DescartarPatron < AreaEsp
  attr_reader :patron, :excepciones

  def initialize(area, hoja_electronica, iterar_fila_tmp = true)
    super(area, hoja_electronica, iterar_fila_tmp)
    @patron = strip_texto_patron(area['patron'])
    @excepciones = area['excepciones'].map!{|v| strip_texto_excepciones(v) }
  end

  # Indica si el patron debe aplicarse para descartar la fila o columna
  # @param Fixnum pos # Fila o columna a iterar
  def valido?(pos)
    verificar_patron?(pos) and !verificar_excepciones?(pos)
  end


private
  # Verifica si se cumple el patron
  # @param Integer pos
  # @return Boolean
  def verificar_patron?(pos)
    patron.each do |k, v|
      if iterar_fila?
        return false unless hoja_electronica.cell(pos, k.to_i).to_s.strip == v['texto']
      else
        return false unless hoja_electronica.cell(k.to_i, pos).to_s.strip == v['texto']
      end
    end

    true
  end

  # Verifica si cumple una excepcion
  # @param Integer pos
  # @return Boolean
  def verificar_excepciones?(pos)
    excepciones.each do |v|
      if iterar_fila?
        return false unless verificar_grupo_excepciones_fila?(v, pos)
      else
        return false unless verificar_grupo_excepciones_columna?(v, pos)
      end
    end

    true
  end

  # Verifica que todo un grupo de excepciones cumpla los valores
  # Realizado de una forma no DRY
  # @param Array grupo # Array con las excepciones de un grupo
  # @param Integer pos
  # @return Boolean
  def verificar_grupo_excepciones_fila?(grupo, pos)
    grupo.each do |v|
      return false unless hoja_electronica.cell(pos, v['pos'].to_i).to_s.strip == v['texto']
    end
    true
  end

  # Verifica que todo un grupo de excepciones cumpla los valores
  # Realizado de una forma no DRY
  # @param Array grupo # Array con las excepciones de un grupo
  # @param Integer pos
  # @return Boolean
  def verificar_grupo_excepciones_columna?(grupo, pos)
    grupo.each do |v|
      return false unless hoja_electronica.cell(v['pos'].to_i, pos).to_s.strip == v['texto']
    end
    true
  end

  # Elimina los espacion en blanco del inicio y fin del texto en el patron
  # Muecho cuidado con los &nbsp; que pueden parecer espacio, son otro caracter
  # @param Hash hash
  def strip_texto_patron(hash)
    hash.each{|k, v| v['texto'].strip! }
  end

  # Elimina los espacios al principio y al final del texto
  # @param Array array
  def strip_texto_excepciones(array)
    array.each{|v| v['texto'].strip!}
  end

end
