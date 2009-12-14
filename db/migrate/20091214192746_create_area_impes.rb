class CreateAreaImpes < ActiveRecord::Migration
  def self.up
    create_table :area_impes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :area_impes
  end
end
