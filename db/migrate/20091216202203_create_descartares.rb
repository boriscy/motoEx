class CreateDescartares < ActiveRecord::Migration
  def self.up
    create_table :descartares do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :descartares
  end
end
