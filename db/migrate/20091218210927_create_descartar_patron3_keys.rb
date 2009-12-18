class CreateDescartarPatron3Keys < ActiveRecord::Migration
  def self.up
    create_table :descartar_patron3_keyses do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :descartar_patron3_keyses
  end
end
