# Clase principal que reqliza la importacion de datos
class Importar < ActiveRecord::Base

  attr_accessor :archivo_tmp

  EXTENCIONES = [".xls", ".xlsx", "ods"]
  CONTENT_TYPS = ["application/vnd.ms-excel", # Excel 97-2003
    "application/octet-stream", # Excel 2007
    "application/vnd.oasis.opendocument.spreadsheet" # Open Officce
  ]

  serialize :areas

  validates_presence_of :areas, :archivo_tmp
  validate :tipo_de_contenido

  #validates_format_of :from_email, :to_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  #validates_length_of :message, :maximum => 500
 
private
  # Valida el tipo de contenido de una hoja electronica a Importar
  # ademas de el nombre
  def tipo_de_contenido()
    errors.add(:archivo_tmp, "Debe seleccionar un archivo con extensión #{EXTENCIONES.join(",")}") unless EXTENCIONES.include?(File.extname(archivo_tmp.original_name).downcase)
    errors.add(:archivo_tmp, "Debe seleccionar archivos Excel o OpenOffice") unless CONTENT_TYPS.include?(archivo_tmp.content_type)
  end
end
