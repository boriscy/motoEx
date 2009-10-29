class CreateArchivos < ActiveRecord::Migration
  def self.up
    create_table :archivos do |t|
      t.string :nombre
      t.text :descripcion
      t.references :usuario

      t.timestamps
    end

  end

  def self.down
    drop_table :archivos
  end
end
