# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
Usuario.create(:nombre => 'admin', :paterno => 'admin', :materno => 'admin', :login => 'admin', :email => 'admin@example.com', :password => 'demo123', :password_confirmation => 'demo123')
