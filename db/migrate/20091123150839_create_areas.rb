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
      t.text :titular
      t.text :fin
      t.text :no_importar

      t.timestamps
    end
  end

  def self.down
    drop_table :areas
  end
end
