# Para paperclip
class AddArchivosFechaModificacion < ActiveRecord::Migration
  def self.up
    add_column :archivos, :fecha_modificacion, :datetime
    add_column :archivos, :archivo_excel_updated_at, :datetime
  end

  def self.down
    remove_column :archivos, :fecha_modificacion
    remove_column :archivos, :archivo_excel_updated_at
  end
end
