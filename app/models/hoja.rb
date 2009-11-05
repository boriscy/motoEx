class Hoja < ActiveRecord::Base
  before_create :crear_hoja_html
  after_save :asignar_ids_html


  belongs_to :archivo

  attr_accessor :numero_hoja

  def ruta
    File.join(RAILS_ROOT, File.dirname(self.archivo.archivo_excel.path), "#{self.numero}.html")
  end

  # Creación de la Hoja HTML usando PHP
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
        begin
          row[col].set_attribute("id", "#{fila}_#{columna}")
        rescue
          debugger
          s=0
        end
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
    cell.inner_html = "<nobr>#{@excel.cell(fila, col)}</nobr>"
  end

  def init_excel
    excel = Excel.new(File.expand_path(self.archivo.archivo_excel.path))
    excel.default_sheet = self.numero + 1
    excel
  end
end
