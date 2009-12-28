class CreateSinonimos < ActiveRecord::Migration
  def self.up
    create_table :sinonimos do |t|
      t.string :nombre
      t.text :mapeado

      t.timestamps
    end
  end

  def self.down
    drop_table :sinonimos
  end
end
