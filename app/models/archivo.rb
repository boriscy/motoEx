class Archivo < ActiveRecord::Base

  before_create :adicionar_usuario
  after_save :crear_hoja_html

  belongs_to :usuario
  
  validates_associated :usuario
  validates_presence_of :nombre
  validates_format_of :archivo_excel_file_name, :with => /\A^.+\.xls$\Z/i, :message => 'Solo archivos excel ".xls"'

  attr_accessible :archivo_excel, :nombre, :descripcion

  has_attached_file :archivo_excel, :path => "archivos/:id/:basename.xls"

 # Validacion de tipos de contenido para excel
  validates_attachment_content_type :archivo_excel, :content_type => ['application/vnd.ms-excel'],
                        :message => 'Solo se permite archivos Excel'
 #'application/x-msexcel','application/ms-excel', 'application/msexcel', 'application/x-excel'

  validates_attachment_presence :archivo_excel, :message => "Debe ingresar un archivo excel"

protected
  def adicionar_usuario
    self.usuario = UsuarioSession.find.record
  end

  # 
  def crear_hoja_html(hoja=0)
    path = File.join(RAILS_ROOT, "lib", "exel_to_html.php")
    sysmtem "php #{path} '#{self.archivo_excel.path}' #{hoja}"
  end

  # Funcion que transforma un archivo excel a HTML
  def excel_to_html

  end

end
