class CreateArchivos < ActiveRecord::Migration
  def self.up
    create_table :archivos do |t|
      t.references :usuario
      t.string :nombre
      t.text :descripcion
      t.text :lista_hojas

      t.timestamps
    end

  end

  def self.down
    drop_table :archivos
  end
end
