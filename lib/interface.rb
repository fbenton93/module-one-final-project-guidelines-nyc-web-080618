#################################
########## BEGIN INTRO ##########
#################################
def welcome_message
  puts "__________________________________"
  puts "WELCOME TO YAN-FOR SALES DATABASE"
  puts "__________________________________"
end

# accepts and returns an number in string-form from the user
def gets_user_input_index
  puts "Please select the option number (example: 1)"
  input = gets.chomp
end

###############################
########## END INTRO ##########
###############################

#######################################
########## BEGIN DIRECTORIES ##########
#######################################

# primary directory
def directory
  puts "1. Global Data"
  puts "2. Local Data"
  puts "3. Create Product"
  puts "4. Update Product"
  puts "5. Manual Order Entry"
  puts "6. Exit"
end

# lists all 'local' stores
def local_store_listings
  puts "Enter Country from List into Console. Please enter number:"
  Store.pluck(:location).each_with_index do |country,index|
      puts "#{index + 1}. #{country}"
      end
end

# lists all products with price - Ref. No. gives the user a number to enter in
# order to select that item
def all_products
  Product.all.each do |product|
      puts "#{product.name}, Current Price: #{product.price}, Ref. No. #{product.id}"
      end
end

# Lists all possible actions for a 'local' store instance
def local_store_info
  puts "1. Store Revenue"
  puts "2. Products"
  puts "3. Customers on Record"
  puts "4. Customer Emails"
  puts "5. VIP Customers"
  puts "6. Return to Main Page"
  puts "7. Exit"
end

# Lists all possible actions for the Store class
def global_directory
  puts "1. Total Revenue All Stores"
  puts "2. Transaction Volume by Card Type"
  puts "3. Global Products"
  puts "4. In-Season Items"
  puts "5. List Product by Category" # enter category -> products and in-season
  puts "6. Best Selling Items"
  puts "7. Highest Grossing Item"
  puts "8. Customers on Record"
  puts "9. VIP Customers"
  puts "10. Go to Local Data"
  puts "11. Exit"
end

#####################################
########## END DIRECTORIES ##########
#####################################


######################################
########## BEGIN NAVIGATORS ##########
######################################

# primary navigator - directs the flow of actions based on user input
def navigator(input)
  case input
  when '1'
    # direct to global data
    # global_directory
    # input = gets_user_input_index
    global_navigator
  when '2'
    # direct to local data
    local_store_listings
    input_location = gets.chomp
    store_instance = local_store_search(input_location)
    local_navigator(store_instance)
  when '3'
    create_product
    load 'bin/run.rb'
  when '4'
    update_product
    load 'bin/run.rb'
  when '5'
    create_order
    load 'bin/run.rb'
  when '6'
    abort
  end

end

# sub navigator - directs flow of actions on the global page based on user input
def global_navigator
  global_directory
  input = gets_user_input_index
  case input
  when '1'
    puts Store.aggregate_revenue
    puts "======================"
  when '2'
    Purchase.card_usage
    puts "======================"
  when '3'
    puts Product.pluck(:name)
    puts "======================"
  when '4'
    puts Product.where(in_season: true).pluck(:name)
    puts "======================"
  when '5'
    Product.products_by_category
    puts "======================"
  when '6'
    puts Product.best_selling
    puts "======================"
  when '7'
    puts Product.highest_gross_product
    puts "======================"
  when '8'
    Customer.all_data
    puts "======================"
  when '9'
    Customer.most_valued_customers
    puts "======================"
  when '10'
    navigator('2')
    puts "======================"
  when '11'
    abort
  end

  puts "Return to list? (y/n)"
  response = gets.chomp
  if response == 'y'
    global_navigator
  else
    load 'bin/run.rb'
  end
end

# sub navigator - directs flow of actions on the local page based on user input
def local_navigator(store)
  local_store_info
  info_selection = gets_user_input_index

  case info_selection
  when '1'
    puts store.revenue
    puts "======================"
  when '2'
    puts store.products.pluck(:name)
    puts "======================"
  when '3'
    puts store.customers.distinct.pluck(:name)
    puts "======================"
  when '4'
    puts store.local_customer_emails
    puts "======================"
  when '5'
    puts store.most_valued_customers
    puts "======================"
  when '6'
    load 'bin/run.rb'
    puts "======================"
  when '7'
    abort
  end

  puts "Return to list? (y/n)"
  response = gets.chomp
  if response == 'y'
    local_navigator(store)
  else
    load 'bin/run.rb'
  end

end

####################################
########## END NAVIGATORS ##########
####################################

####################################
########## BEGIN SEARCHES ##########
####################################

# pulls up the store instance that our methods will operate on when called
# inside of the local store page
def local_store_search(input_location)
  return_value = Store.find(input_location.to_i)
  if return_value == nil
    puts "Invalid Entry."
  end
  return_value
end

##################################
########## END SEARCHES ##########
##################################


###########################################
########## BEGIN CRUD OPERATIONS ##########
###########################################

# prompts a user to manually enter attributes for each product; creates the
# product; iterates through each store and adds it to inventory by creating
# a StoreProduct instance for each store
def create_product
  puts "Enter a name for the product:"
    name = gets.chomp
  puts "Enter a category for the product:"
    category = gets.chomp
  puts "Enter a price for the product:"
    price = gets.chomp.to_i
  puts "In Season? (true/false)"
    in_season = gets.chomp


  new_product = Product.create(name: name, category: category, price: price, in_season: in_season)
  i = 0
  while i < Store.all.length do
    StoreProduct.create(store_id: (i+1), product_id: new_product.id)
    i += 1
  end

  puts "Product Created:"
  puts "#{new_product.name} - #{new_product.category} - #{new_product.price} - #{new_product.in_season}"
end

# prompts the user if they want to update either the price or its availability
# based upon its 'in_season' status
def update_product
  all_products
  puts "Enter Product from List into Console. Please use reference number:"
  ref_num = gets.chomp
  product = Product.find(ref_num)
  puts "Update price? (y/n)"
  response = gets.chomp
  if response == 'y'
    puts "Enter new price:"
    new_price = gets.chomp
    product.update(price: new_price)
  end

  puts "Update in-season status? (y/n)"
  response = gets.chomp
  if response == 'y'
    puts "Enter in-season status (true/false)"
    new_status = gets.chomp
    product.update(in_season: new_status)
  end

end

# allows an employee to manually enter a new order with a product and customer
# if a customer doesn't exist in AR, it will create a new entry and prompt for
# a name; ideally, the bulk of order entries would be seeded with a CSV importer
def create_order
  puts "_______________________________________________"
  puts "Welcome to the Yan-For Manual Order Entry Form"
  puts "_______________________________________________"
  puts "Enter customer email:"
  email = gets.chomp
  if Customer.find_by(email: email)
    customer_id = Customer.find_by(email: email).id
    puts "Found existing customer record."
  else
    puts "No such customer registered in our records. Please enter the customer's full name:"
    full_name = gets.chomp
    customer_id = Customer.create(name: full_name, email: email).id
  end
  puts "======================"
  puts "Currently Available:"
  all_products
  puts "Please enter the Product Ref. No.:"
  prod_id = gets.chomp
  puts "Please Card Name/Type (example: Visa):"
  puts "1. Visa"
  puts "2. MasterCard"
  puts "3. Discover"
  puts "4. Debit"
  card = gets.chomp

  Purchase.create(customer_id: customer_id, product_id: prod_id, card_type: card)

  puts "Order Submitted."

end

#########################################
########## END CRUD OPERATIONS ##########
#########################################
