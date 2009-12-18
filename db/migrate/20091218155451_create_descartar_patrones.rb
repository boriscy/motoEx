class CreateDescartarPatrones < ActiveRecord::Migration
  def self.up
    create_table :descartar_patrones do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :descartar_patrones
  end
end
