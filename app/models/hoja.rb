class Hoja < ActiveRecord::Base
  after_save :crear_hoja_html

  belongs_to :archivo


  def ruta
    File.join(RAILS_ROOT, File.dirname(self.archivo.archivo_excel.path), "#{self.numero}.html")
  end

  # Creación de la Hoja HTML usando PHP
  def crear_hoja_html(num=0)
    path = File.join(RAILS_ROOT, "lib", "php", "excel_to_html.php")

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
 
end
