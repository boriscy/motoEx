class CreateEncabezados < ActiveRecord::Migration
  def self.up
    create_table :encabezados do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :encabezados
  end
end
