class AddUsuarioRol < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :rol, :string, :limit => 20, :default => 'usuario'#Usuario::TIPOS.first.last
  end

  def self.down
    remove_column :usuarios, :rol
  end
end
