# Para paperclip
class AddArchivosFechaModificacion < ActiveRecord::Migration
  def self.up
    add_column :archivos, :fecha_modificacion, :datetime
  end

  def self.down
    remove_column :archivos, :fecha_modificacion
  end
end
