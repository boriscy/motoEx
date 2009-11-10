class AddHojasFechaArchivo < ActiveRecord::Migration
  def self.up
    add_column :hojas, :fecha_archivo, :datetime
  end

  def self.down
    remove_column :hojas, :fecha_archivo, :datetime
  end
end
