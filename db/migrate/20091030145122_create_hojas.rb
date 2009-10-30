class CreateHojas < ActiveRecord::Migration
  def self.up
    create_table :hojas do |t|
      t.references :archivo
      t.string :nombre
      t.integer :numero
    end
  end

  def self.down
    drop_table :hojas
  end
end
