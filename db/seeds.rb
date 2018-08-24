require_relative '../lib/models/customer'
require_relative '../lib/models/product'
require_relative '../lib/models/purchase'
require_relative '../lib/models/store_product'
require_relative '../lib/models/store'
require 'faker'

puts "Beginning seed."
# 50.times do
#   name = Faker::Name.name
#   email = Faker::Internet.email(name)
#   Customer.create(name: name, email: email )
# end


# Product.create(name: "Alpaca Vest", category: "Outerwear", price: 350, in_season: true)
# Product.create(name: "Alpaca Jacket", category: "Outerwear", price: 500, in_season: true)
# Product.create(name: "Leather Jacket", category: "Outerwear", price: 900, in_season: true)
# Product.create(name: "Flannel Shirt", category: "Casual", price: 75, in_season: true)
# Product.create(name: "Silk Shirt", category: "Formal Wear", price: 125, in_season: true)
# Product.create(name: "Silk Dress", category: "Formal Wear", price: 300, in_season: true)
# Product.create(name: "Cotton Shirt", category: "Casual", price: 25, in_season: true)
# Product.create(name: "Jean Shorts", category: "Casual", price: 20, in_season: false)
# Product.create(name: "Chromexcel Boots", category: "Shoes", price: 315, in_season: true)
# Product.create(name: "Aviator Glasses", category: "Accessories", price: 190, in_season: true)
# Product.create(name: "Lambskin Gloves", category: "Accessories", price: 110, in_season: true)
# Product.create(name: "Merino Wool Socks", category: "Accessories", price: 12, in_season: true)
# Product.create(name: "9-inch Swimtrunks", category: "Swimwear", price: 35, in_season: false)
# Product.create(name: "Linen Button-Down", category: "Casual", price: 70, in_season: false)


# Purchase.create(customer_id: 2, product_id: 1, card_type: "Visa")
# Purchase.create(customer_id: 2, product_id: 1, card_type: "Visa")
# Purchase.create(customer_id: 3, product_id: 1, card_type: "Visa")
# Purchase.create(customer_id: 2, product_id: 2, card_type: "Visa")
# Purchase.create(customer_id: 3, product_id: 3, card_type: "Visa")


# 50.times do
#   Purchase.create(customer_id: rand(1..Custoqmer.last.id), product_id: rand(1..Product.last.id))
# end


# Store.create(location: "United States")
# Store.create(location: "China")
# Store.create(location: "Canada")

# Store.all.each do |store|
#   Product.all.each do |product|
#     StoreProduct.create(store_id: store.id, product_id: product.id)
#   end
# end
StoreProduct.create(store_id: 1, product_id: 2)
StoreProduct.create(store_id: 2, product_id: 1)
StoreProduct.create(store_id: 3, product_id: 3)
StoreProduct.create(store_id: 1, product_id: 3)
StoreProduct.create(store_id: 2, product_id: 3)

puts "Seed complete."
