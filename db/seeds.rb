# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create([
   {
    :name => "admin",
    :email => "admin@heyu.net", 
    :password => "welcome", 
    :password_confirmation => "welcome",
    :admin => true
  },
  {
    :name => "fred", 
    :email => "fred@heyu.net", 
    :password => "welcome", 
    :password_confirmation => "welcome",
    :admin => true
  }
])


Page.create([
   {
    :title => "Home Page",
    :body => "Body content", 
    :permalink => "home"
  }
])
