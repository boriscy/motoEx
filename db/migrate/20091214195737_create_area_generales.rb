class CreateAreaGenerales < ActiveRecord::Migration
  def self.up
    create_table :area_generales do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :area_generales
  end
end
