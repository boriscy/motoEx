class AddAreasRangoColumnas < ActiveRecord::Migration
  def self.up
    rename_column :areas, :rango, :rango_filas
    add_column :areas, :rango_columnas, :integer, :default => 0
  end

  def self.down
    rename_column :areas, :rango_filas, :rango
    remove_column :areas, :rango_columnas
  end
end
