class AddArchivosAdjuntos < ActiveRecord::Migration
  def self.up
    add_column :archivos, :archivo_excel_file_name, :string
    add_column :archivos, :archivo_excel_file_size, :integer
    add_column :archivos, :archivo_excel_updated_at, :datetime
  end

  def self.down
    remove_column :archivos, :archivo_excel_file_name
    remove_column :archivos, :archivo_excel_file_size
    remove_column :archivos, :archivo_excel_updated_at
  end
end
