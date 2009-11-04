class Hoja < ActiveRecord::Base
  before_create :crear_hoja_html
  after_save :asignar_ids_html


  belongs_to :archivo

  attr_accessor :numero_hoja

  def ruta
    File.join(RAILS_ROOT, File.dirname(self.archivo.archivo_excel.path), "#{self.numero}.html")
  end

  # Creación de la Hoja HTML usando PHP
  def crear_hoja_html(num=0)
    path = File.join(RAILS_ROOT, "lib", "php", "excel_to_html.php")
    num = self.numero_hoja if self.numero_hoja
    self.numero = num

    begin
      texto = `php #{path} '#{File.expand_path(self.archivo.archivo_excel.path)}' #{num} '#{PATRON_SEPARACION}'`
      hojas, html = texto.split(PATRON_SEPARACION)
      hojas = ActiveSupport::JSON.decode(hojas)
      archivo = File.dirname(self.archivo.archivo_excel.path) + "/#{num}.html"
      f = File.new(File.join(RAILS_ROOT, archivo) ,"w+")
      f.write(html)
      f.close()
      self.nombre = hojas[num]
#      asignar_ids_html()
    rescue
      raise "No se pudo guardar el archivo HTML, posible error en #{path}"
    end
  end

  # Ejecuta procesos sobre la hoja creada de HTML
  def asignar_ids_html
    require 'nokogiri'

    @areas = {}
    html = Nokogiri::HTML(File.open(self.ruta))# {|f| Hpricot(f)}
    rows = html.search("tr").size - 1
    cols = html.search("tr:first th").size - 2
    
    (1..rows).each do |i|
      row = html.search("tr:eq(#{i}) td")
      col = 0
      (1..cols).each do |j|
        unless @areas["#{i}-#{j}"]
          begin
          row[col].set_attribute("id", "#{i}_#{j}")
          rescue
            debugger
            s=0
          end
          crear_merged(row[col], i, j)
          col += 1
        end
      end
    end

    f = File.new(self.ruta, "w+")
    f.write(html.to_xhtml)
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
    rowspan = cell.attributes["rowspan"].value.to_i if cell.attributes["rowspan"] and cell.attributes["rowspan"].value.to_i > 1
    colspan = cell.attributes["colspan"].value.to_i if cell.attributes["colspan"] and cell.attributes["colspan"].value.to_i > 1

    if colspan > 1 or rowspan > 1
      rowspan.times do |i|
        colspan.times do |j|
          @areas["#{i + fila}-#{j + col}"] = true
        end
      end
    end
  end
end
