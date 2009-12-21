# Clase principal que reqliza la importacion de datos
class Importar < ActiveRecord::Base

  attr_accessor :hoja_id

  belongs_to :area
  #belongs_to :hoja

  validates_presence_of :area_id

  #validates_format_of :from_email, :to_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  #validates_length_of :message, :maximum => 500
  
end
