class Archivo < ActiveRecord::Base

  before_create :adicionar_usuario
  before_save :crear_fecha_modificacion

  belongs_to :usuario
  has_many :hojas
  
  validates_associated :usuario
  validates_presence_of :nombre
  validates_format_of :archivo_excel_file_name, :with => /\A^.+\.xls$\Z/i, :message => 'Solo se permite archivos excel ".xls"'

  attr_accessible :archivo_excel, :nombre, :descripcion, :prelectura, :archivo_excel_updated_at
  serialize :lista_hojas

  has_attached_file :archivo_excel, :path => "archivos/:id/:basename.xls"

 # Validacion de tipos de contenido para excel
  validates_attachment_content_type :archivo_excel, :content_type => ['application/vnd.ms-excel'],
                        :message => 'Solo se permite archivos Excel'
 #'application/x-msexcel','application/ms-excel', 'application/msexcel', 'application/x-excel'

  validates_attachment_presence :archivo_excel, :message => "Debe ingresar un archivo excel"

  # Metodod para poder buscar una hoja determinada, en caso de que no haya la hoja
  # crea la hoja que se busca en caso de que no exista
  def hoja(num=0)
    h = self.hojas.find_by_numero(num)
    self.hojas << (h = Hoja.new(:numero => num)) unless h
    h
  end

protected
  # Asigna el id del usuario que esta logueado
  def adicionar_usuario
    self.usuario = UsuarioSession.find.record
  end

  # Crear una fecha de modificación del archivo solo para campos que tienen relevancia
  # cuando se crean las hojas HTML del archivo excel
  def crear_fecha_modificacion
    if self.id
      old_model = self.class.find(self.id)
      test = false
      if File.atime(old_model.archivo_excel.path) != File.atime(self.archivo_excel.path) or old_model.prelectura != self.prelectura
        self.fecha_modificacion = Time.zone.now
      end
    else
      self.fecha_modificacion = Time.zone.now
    end
  end

end
