class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.references :hoja
      t.string :nombre
      t.string :celda_inicial
      t.string :celda_final
      t.integer :rango
      t.boolean :fija
      t.boolean :iterar_fila
      t.text :encabezado
      t.text :fin
      t.text :descartar

      t.timestamps
    end
  end

  def self.down
    drop_table :areas
  end
end
