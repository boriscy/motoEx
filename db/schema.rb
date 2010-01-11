# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100106133154) do

  create_table "archivos", :force => true do |t|
    t.integer  "usuario_id"
    t.string   "nombre"
    t.text     "descripcion"
    t.text     "lista_hojas"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "archivo_excel_file_name"
    t.integer  "archivo_excel_file_size"
    t.boolean  "prelectura",               :default => false
    t.datetime "archivo_excel_updated_at"
    t.datetime "fecha_modificacion"
    t.datetime "fecha_archivo"
  end

  create_table "areas", :force => true do |t|
    t.integer  "hoja_id"
    t.string   "nombre"
    t.string   "celda_inicial"
    t.string   "celda_final"
    t.integer  "rango"
    t.boolean  "fija"
    t.boolean  "iterar_fila"
    t.text     "encabezado"
    t.text     "fin"
    t.text     "descartar"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "titular"
    t.text     "sinonimos"
  end

  create_table "hojas", :force => true do |t|
    t.integer  "archivo_id"
    t.string   "nombre"
    t.integer  "numero"
    t.datetime "fecha_archivo"
  end

  create_table "importares", :force => true do |t|
    t.integer  "usuario_id"
    t.string   "areas"
    t.integer  "archivo_size"
    t.string   "archivo_nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sinonimos", :force => true do |t|
    t.string   "nombre"
    t.text     "mapeado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre",            :limit => 50
    t.string   "paterno",           :limit => 30
    t.string   "materno",           :limit => 30
    t.string   "email"
    t.string   "login",             :limit => 20
    t.string   "password_salt"
    t.string   "crypted_password"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
