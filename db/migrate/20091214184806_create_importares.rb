class CreateImportares < ActiveRecord::Migration
  def self.up
    create_table :importares do |t|
      t.integer :usuario_id
      t.integer :area_id
      t.integer :archivo_size
      t.string :hoja_electronica
      t.timestamps
    end
  end

  def self.down
    drop_table :importar
  end
end
