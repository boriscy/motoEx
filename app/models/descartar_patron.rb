class DescartarPatron < AreaEsp
  attr_reader :patron, :excepciones

  
  def initialize(area, hoja_electronica, iterar_fila = true)
    super(area, hoja_electronica, iterar_fila)
    @patron = strip_texto_patron(area['patron'])
    @excepciones = strip_texto_excepciones(area['excepciones'])
  end

  # Indica si el patron debe aplicarse para descartar la fila o columna
  # @param Fixnum pos # Fila o columna a iterar
  def valido?(pos)
    verificar_patron?(pos) and !verificar_excepciones?(pos)
  end


private
  # Verifica si se cumple el patron
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
  def verificar_excepciones?(pos)
    excepciones.each do |v|
      if iterar_fila?
        return false unless hoja_electronica.cell(pos, v['pos'].to_i).to_s.strip == v['texto']
      else
        return false unless hoja_electronica.cell(v['pos'].to_i, pos).to_s.strip == v['texto']
      end
    end

    true
  end

  # Elimina los espacion en blanco del inicio y fin del texto en el patron
  # Muecho cuidado con los &nbsp; que pueden parecer espacio, son otro caracter
  def strip_texto_patron(hash)
    hash.each{|k, v| v['texto'].strip! }
  end

  def strip_texto_excepciones(array)
    array.each{|v| v['texto'].strip!}
  end

end
