# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "...... DB setup initiated...."

User.create!(first_name:  'Admin',
             last_name: 'User',
             email: 'admin@e-com.org',
             password:              '123456',
             password_confirmation: '123456',
             super_user: true
            )

User.create!(first_name:  'Sai',
             last_name: 'Ch',
             email: 'csai@e-com.org',
             password:              '123456',
             password_confirmation: '123456',
             super_user: true
            )

10.times do |n|
  email = Faker::Internet.email
  password = Faker::Internet.password(10, 20, true, true)
  User.create!(first_name:  Faker::Name.unique.name,
               last_name: Faker::Name.unique.name,
               email: email,
               password:              password,
               password_confirmation: password,
               super_user: false,
               )
end


puts "Total number of users: #{User.all.count}"

Product.create({:title=>"Samsung S9", :price => 89899.10})
Product.create({:title=>"Google Pixel2", :price => 92899.99})
Product.create({:title=>"iPhone XS", :price => 119999.00})
Product.create({:title=>"One Plus 7T", :price => 59999.00})
Product.create({:title=>"Poco F1", :price => 19999.90})
Product.create({:title=>"Redmi 7Pro", :price => 14000.00})

threads = []
15.times do |pr|
  threads << Thread.new do
    product_images = []
    product_images << Faker::Avatar.image << Faker::Avatar.image << Faker::Avatar.image
    Product.create!({title: Faker::Appliance.brand, price: Faker::Number.decimal(Faker::Number.within(1..5), 2), remote_product_images_urls: product_images })
    puts "#{pr} product created."
  end
end

threads.map(&:join)

puts "Total number of products: #{Product.all.count}"
puts "Product names: #{Product.all.pluck("title")}"


# Create Order with user_id
# Create Cart with user_id
# Create LineItem with quantity, order, cart, product id’s

10.times do |ord|
  order = Order.new
  cart = Cart.new
  line_item = LineItem.new

  user = User.find(Faker::Number.within(1..8))
  product = Product.find(Faker::Number.within(1..8))

  order.user_id = user.id
  order.save!

  cart.user_id = user.id
  cart.save!

  line_item.quantity = Faker::Number.within(1..5)
  line_item.order_id = order.id
  line_item.cart_id = cart.id
  line_item.product_id = product.id
  line_item.save!
end

puts "...... DB setup completed...."
