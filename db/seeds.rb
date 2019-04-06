# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  'Admin User',
             email: 'admin@e-com.org',
             password:              '123456',
             password_confirmation: '123456',
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  'Sai Ch',
             email: 'csai@e-com.org',
             password:              '123456',
             password_confirmation: '123456',
             admin:     false,
             activated: true,
             activated_at: Time.zone.now)

7.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n + 1}@e-com.org"
  password = 'e-com@123'
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               admin: false,
               activated: true,
               activated_at: Time.zone.now)
end

Product.create({:title=>"Samsung S9", :price => 89899.10})
Product.create({:title=>"Google Pixel2", :price => 92899.99})
Product.create({:title=>"iPhone XS", :price => 119999.00})
Product.create({:title=>"One Plus 7T", :price => 59999.00})
Product.create({:title=>"Poco F1", :price => 19999.90})
Product.create({:title=>"Redmi 7Pro", :price => 14000.00})


puts "Total number of products: #{Product.all.count}"
puts "Product names: #{Product.all.pluck("title")}"

Cart.destroy_all
puts "\nTotal cart count: #{Cart.all.count}"


