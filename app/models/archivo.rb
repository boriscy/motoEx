class Archivo < ActiveRecord::Base

  before_create :adicionar_usuario

  belongs_to :usuario
  
  validates_associated :usuario
  validates_presence_of :archivo_excel, :nombre
  validates_presence_of :nombre


  attr_accessible :archivo_excel, :nombre, :descripcion

  has_attached_file :archivo_excel, :path => "archivos/:id/:basename.xls"

 # Validacion de tipos de contenido para excel
  validates_attachment_content_type :archivo_excel, :content_type => ['application/vnd.ms-excel',
			'application/x-msexcel', 'application/ms-excel', 'application/msexcel',	'application/x-excel'],
                        :message => 'Solo se permite archivos Excel'


protected
  def adicionar_usuario
    self.usuario = UsuarioSession.find.record
  end

end
