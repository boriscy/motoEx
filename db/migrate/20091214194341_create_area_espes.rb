class CreateAreaEspes < ActiveRecord::Migration
  def self.up
    create_table :area_espes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :area_espes
  end
end
