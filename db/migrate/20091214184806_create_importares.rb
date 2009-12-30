class CreateImportares < ActiveRecord::Migration
  def self.up
    create_table :importares do |t|
      t.integer :usuario_id
      t.string :areas
      t.integer :archivo_size
      t.string :archivo_nombre
      t.timestamps
    end
  end

  def self.down
    drop_table :importares
  end
end
