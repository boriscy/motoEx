class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.string :nombre, :limit => 50
      t.string :paterno, :limit => 30
      t.string :materno, :limit => 30
      t.string :email
      t.string :login, :limit => 20
      t.string :password_salt
      t.string :crypted_password
      t.string :persistence_token

      t.timestamps
    end
  end

  def self.down
    drop_table :usuarios
  end
end
