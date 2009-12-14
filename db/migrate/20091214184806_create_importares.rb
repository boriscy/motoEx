class CreateImportares < ActiveRecord::Migration
  def self.up
    create_table :importares do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :importares
  end
end
