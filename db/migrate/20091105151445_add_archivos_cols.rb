class AddArchivosCols < ActiveRecord::Migration
  def self.up
    add_column :archivos, :prelectura, :boolean, :default => false
  end

  def self.down
    remove_column :archivos, :prelectura
  end
end
