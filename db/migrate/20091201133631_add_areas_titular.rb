class AddAreasTitular < ActiveRecord::Migration
  def self.up
    add_column :areas, :titular, :string
  end

  def self.down
    remove_column :areas, :titular
  end
end
