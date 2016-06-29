# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



 Group.create!({:name => 'All Users', :description => 'Default Group'})
#Group.find_or_create_by_name("All Users")


users = User.all
grp = Group.find_by_name("All Users")
users.each do |user|
# user.groups.create!({:name => 'All Users', :description => 'Default Group'})
user.groups << grp
# user.groups.find_or_create_by_name("All Users")
end