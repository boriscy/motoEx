class Archivo < ActiveRecord::Base

  before_create :adicionar_usuario

  belongs_to :usuario
  has_many :hojas
  
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


end
