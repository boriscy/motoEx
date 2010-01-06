class AddAreasSinonimos < ActiveRecord::Migration
  def self.up
    add_column :areas, :sinonimos, :text
  end

  def self.down
    remove_column :areas, :sinonimos
  end
end
