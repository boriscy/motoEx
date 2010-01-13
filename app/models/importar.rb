# Clase principal que reqliza la importacion de datos
class Importar < ActiveRecord::Base

  before_create :adicionar_usuario
  before_save :preparar_datos
  after_save :importar
  after_save :borrar_archivo_tmp

  attr_accessor :archivo_tmp
  attr_reader :importado # Variable en la cual se almance todos los datos de la imoprtacion
  serialize :areas

  EXTENCIONES = [".xls", ".xlsx", "ods"]
  CONTENT_TYPS = ["application/vnd.ms-excel", # Excel 97-2003
    "application/octet-stream", # Excel 2007
    "application/vnd.oasis.opendocument.spreadsheet" # Open Officce
  ]

  serialize :areas

  validates_presence_of :areas, :archivo_tmp, :archivo_nombre
  #validates_format_of :archivo_nombre, :with => /\A\Z/i
  validate :tipo_de_contenido

  #validates_format_of :from_email, :to_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  #validates_length_of :message, :maximum => 500
  


  # Realiza la importacion de los datos, es posible realizar este metodo sin salvar esta clase
  def importar()
    ret = {}
    hoja_electronica = asignar_hoja_electronica()
    areas.each do |v|
      area = Area.find(v)
      hoja_electronica.default_sheet = area.hoja.numero
      area_general = AreaGeneral.new(area, hoja_electronica, area.iterar_fila)
      ret[v] = area_general.leer()
    end

    @importado = ret
  end
 
private
  # Asigfna la hoja electronica que se va usar para leer los datos
  def asignar_hoja_electronica()
    case File.extname(archivo_tmp).downcase
    when ".xls" then Excel.new(archivo_tmp)
    when ".xlsx" then Excelx.new(archivo_tmp)
    when ".ods" then Openoffice.new(archivo_tmp)
    end
  end


  # Valida el tipo de contenido de una hoja electronica a Importar
  # ademas de el nombre
  def tipo_de_contenido()
    errors.add(:archivo_tmp, "Debe seleccionar un archivo con extensión #{EXTENCIONES.join(",")}") unless EXTENCIONES.include?(File.extname(archivo_nombre).downcase)
    # errors.add(:archivo_tmp, "Debe seleccionar un archivo válido") unless self.archivo_tmp.methods.include? "path"
  end

  # Asigna el id del usuario que esta logueado
  def adicionar_usuario
    self.usuario_id = UsuarioSession.find.record.id
  end

  # Elimina el archivo temporal una ves que ya fue usado
  def borrar_archivo_tmp
    File.delete(self.archivo_tmp)
  end


  # Prepara todos los datos para que pudan ser usados
  def preparar_datos()
    self.areas = areas.map(&:last) if self.areas.kind_of? Hash
    self.archivo_nombre.gsub!(/\\/, '/') if self.archivo_nombre =~ /^[a-z]:.*/i
    self.archivo_nombre = File.basename(self.archivo_nombre)

    # Almacenamiento temporal del archivo
    tmp = File.join(RAILS_ROOT, "tmp/archivos/#{Time.now.to_i}#{self.archivo_nombre}")
    File.copy(self.archivo_tmp.path, tmp)
    self.archivo_tmp = tmp
    self.archivo_size = File.size(tmp)
  end
end
