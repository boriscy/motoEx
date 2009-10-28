class AddArchivosAdjuntos < ActiveRecord::Migration
  def self.up
    add_column :archivos, :archivo_html_file_name, :string
    add_column :archivos, :archivo_html_file_size, :integer
    add_column :archivos, :archivo_excel_file_name, :string
    add_column :archivos, :archivo_excel_file_size, :integer
  end

  def self.down
  end
end
