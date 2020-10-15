# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.new
admin.email = 'admin@coind.co.id'
admin.username = 'admin'
admin.password = 'password'
admin.password_confirmation = 'password'
admin.first_name = 'Admin'
admin.last_name = 'Coder'
admin.date_of_birth = '17/08/1945'
admin.phone_number = '081800008888'
admin.programming_skill = 5
admin.save

admin.add_role 'admin'
