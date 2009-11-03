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
    rescue
      raise "No se pudo guardar el archivo HTML, posible error en #{path}"
    end
  end

  # Ejecuta procesos sobre la hoja creada de HTML
  def asignar_ids_html
    require 'hpricot'
    
    html = File.open(self.ruta){|f| Hpricot(f)}
    rows = html.search("tr").size - 1
    cols = html.search("tr:first th").size - 1
    
    rows.times do |i|
      row = html.search("td")
      cols.times do |j|
        
      end
    end

  end

end
