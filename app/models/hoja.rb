class Hoja < ActiveRecord::Base
  before_create :crear_hoja_html
  after_save :asignar_ids_html


  belongs_to :archivo

  attr_accessor :numero_hoja

  # Retorna la ruta en el que esta almacenado el archivo html
  #   Hoja.first.ruta # => /home/mydir/myrailsapp/files/1/1.html
  def ruta
    File.join(RAILS_ROOT, File.dirname(self.archivo.archivo_excel.path), "#{self.numero}.html")
  end

  # Creación de la hoja html desde un archivo excel usando PHP
  # para luego ser utilizado en la edición, el número de hoja es obtenido
  # del campo *:hoja* del modelo *Hoja*
  def crear_hoja_html()
    path = File.join(RAILS_ROOT, "lib", "php", "excel_to_html.php")
    #num = self.numero_hoja if self.numero_hoja
    self.numero ||= 0

    begin
      texto = `php #{path} '#{File.expand_path(self.archivo.archivo_excel.path)}' #{self.numero} '#{PATRON_SEPARACION}'`
      hojas, html = texto.split(PATRON_SEPARACION)
      hojas = ActiveSupport::JSON.decode(hojas)
      archivo = File.dirname(self.archivo.archivo_excel.path) + "/#{self.numero}.html"

      f = File.new(File.join(RAILS_ROOT, archivo) ,"w+")
      f.write(html)
      f.close()
      self.nombre = hojas[self.numero]
      # Actualización de la lista de hojas de archivo en caso de que la fecha de modificacion sea diferente
      unless self.archivo.fecha_modificacion == self.fecha_archivo
        unless self.archivo.lista_hojas == hojas
          return false unless self.archivo.update_attribute(:lista_hojas, hojas)
        end
      end
      self.fecha_archivo = self.archivo.fecha_modificacion
    rescue
      raise "No se pudo guardar el archivo HTML, posible error en #{path}"
    end
  end

  # Ejecuta procesos sobre la hoja creada de HTML
  # Se usa fila y columna con ids que parten del 1_1 y no del 0_0
  # debido al manejo que eraliza roo
  def asignar_ids_html

    @areas = {}
    html = File.open(self.ruta){|f| Hpricot(f)}
    rows = html.search("tr").size - 1
    cols = html.search("tr:first th").size - 1
    
    rows.times do |i|
      row = html.search("tr:eq(#{i}) td")
      fila = i + 1
      col = 0
      cols.times do |j|
        columna = j + 1
        unless @areas["#{fila}-#{columna}"]
          row[col].set_attribute("id", "#{fila}_#{columna}")
          # Realizar la prelectura del documento en caso de que este seleccionado
          prelectura(row[col], fila, columna) if self.archivo.prelectura
          crear_merged(row[col], fila, columna)
          col += 1
        end
      end
    end

    f = File.new(self.ruta, "w+")
    f.write(html.html)
    f.close

  end

  # Presenta el html de la hoja
  def html
    File.open(self.ruta).inject(""){|text, v| text << v }
  end
  
private

  # Crea un áreas para poder identificar en caso de colspan
  # y rowspan cuando se asignan los ids a las celdas "td"
  # @param Hpricot::Elem cell
  # @param Fixnum fila
  # @param Fixnum col
  def crear_merged(cell, fila, col)
    @areas ||= {}
    rowspan, colspan = 1, 1
    rowspan = cell.attributes["rowspan"].to_i if cell.attributes["rowspan"] and cell.attributes["rowspan"].to_i > 1
    colspan = cell.attributes["colspan"].to_i if cell.attributes["colspan"] and cell.attributes["colspan"].to_i > 1

    if colspan > 1 or rowspan > 1
      rowspan.times do |i|
        colspan.times do |j|
          @areas["#{i + fila}-#{j + col}"] = true
        end
      end
    end
  end

  # Realiza la prelectura de los datos para documentos que no se puede
  # leer sus datos con el php-excel-reader
  def prelectura(cell, fila, col)
    @excel ||= init_excel()
    cell.inner_html = "#{@excel.cell(fila, col)}"
  end

  def init_excel
    excel = Excel.new(File.expand_path(self.archivo.archivo_excel.path))
    excel.default_sheet = self.numero + 1
    excel
  end

###############################################################
  # Metodos de la instancia Hoja
  class << self
    # Realiza la busqueda de una hoja de lo contrario la crea
    # y de ser necesario actualiza el HTML de la hoja
    # @param Fixnum archivo_id # Archivo
    # @param Fixnum numero # Número de hoja
    def buscar_o_crear(archivo_id, numero=0)
      hoja = self.find_by_archivo_id_and_numero(archivo_id, numero)
      if hoja.nil?
        hoja = Hoja.create(:numero => numero, :archivo_id => archivo_id)
      elsif hoja and hoja.fecha_archivo != hoja.archivo.fecha_modificacion
        hoja.fecha_archivo = hoja.archivo.fecha_modificacion
        hoja.crear_hoja_html()
        hoja.save
      end
      hoja
    end
  end
end
