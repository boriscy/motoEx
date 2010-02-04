# Clase para almacenar los usuarios
class Usuario < ActiveRecord::Base

  # Callbacks
  before_save :squish_params


  # Relaciones
  has_many :archivos

  attr_accessor :old_password

  # Se utiliza authlogic como metodo de autenticacion
  # Configuraciones de authogic
  acts_as_authentic do |config|
    config.login_field = :login
    config.merge_validates_format_of_login_field_options(:with => /\A^[a-z_0-9@]+$\Z/i)
    config.merge_validates_length_of_login_field_options(:within => 4..20)
#    config.merge_validates_length_of_password_field_options(:within => 8..40)
  end

  # attr_accessible
  attr_accessible :nombre, :login, :paterno, :materno, :password, :email, :password_confirmation

  validates_presence_of :nombre, :paterno, :materno
  validates_format_of :nombre, :with => /\A[#{REG_ES}\s]+\Z/, :unless => proc{|usuario| usuario.nombre.blank?}
  validates_format_of :paterno, :with => /\A[#{REG_ES}\s]+\Z/, :unless => proc{|usuario| usuario.paterno.blank?}
  validates_format_of :materno, :with => /\A[#{REG_ES}\s]+\Z/, :unless => proc{|usuario| usuario.materno.blank?}

  # Nombre completo uniendo nombre paterno y materno
  def nombre_completo
    "#{nombre} #{paterno} #{materno}"
  end


  # Limpia los espacion en blaco de los campos :nombre, :paterno y :materno
  def squish_params
    squish_data(:nombre, :paterno, :materno)
  end

  # metodo por defecto
  def to_s
    nombre_completo
  end

  # Realiza la actualizacion del password
  def actualizar_password(params)
    usuario = UsuarioSession.find().record
  end

end
