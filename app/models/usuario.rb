# coding: utf-8

# Clase para almacenar los usuarios
class Usuario < ActiveRecord::Base

  # Callbacks
  before_save :limpiar_campos

  ROLES = [['Usuario', 'usuario'],['Administrador', 'admin']]

  # Relaciones
  has_many :archivos

  attr_accessor :password_old


  # attr_accessible
  attr_accessible :nombre, :login, :paterno, :materno, :password, :email, :password_confirmation

  # Validaciones
  validates_inclusion_of :rol, :in => ROLES.map(&:last)
  validates_presence_of :nombre, :paterno, :materno
  validates_format_of :nombre, :with => /\A[#{REG_ES}\s]+\Z/, :unless => proc{|usuario| usuario.nombre.blank?}
  validates_format_of :paterno, :with => /\A[#{REG_ES}\s]+\Z/, :unless => proc{|usuario| usuario.paterno.blank?}
  validates_format_of :materno, :with => /\A[#{REG_ES}\s]+\Z/, :unless => proc{|usuario| usuario.materno.blank?}

  # Se utiliza authlogic como metodo de autenticacion
  # Configuraciones de authogic
  acts_as_authentic do |config|
    config.login_field = :login
    config.merge_validates_format_of_login_field_options(:with => /\A^[a-z_0-9@]+$\Z/i)
    config.merge_validates_length_of_login_field_options(:within => 4..20)
#    config.merge_validates_length_of_password_field_options(:within => 8..40)
  end


  # Nombre completo uniendo nombre paterno y materno
  def nombre_completo
    "#{nombre} #{paterno} #{materno}"
  end

  # metodo por defecto
  def to_s
    nombre_completo
  end

  # Realiza la actualizacion del password
  def actualizar_password(password, password_confirmation)
    update_attributes(:password => password, :password_confirmation => password_confirmation)
  end

  # sirve para presentar tipo
  def ver_rol
    ROLES.find{|v| v.last == rol }.first
  end

private
  # Limpia los espacion en blanco de los campos :nombre, :paterno y :materno
  def limpiar_campos
    #[:nombre, :paterno, :materno].each{|v| self[v] = v.send(v).squish }
    squish_data(:nombre, :paterno, :materno)
  end

end
