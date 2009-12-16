class CreateTitulares < ActiveRecord::Migration
  def self.up
    create_table :titulares do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :titulares
  end
end
