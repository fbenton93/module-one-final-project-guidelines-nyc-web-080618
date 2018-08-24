require 'pry'
class Customer < ActiveRecord::Base
  validates :email, presence: true
  has_many :purchases
  has_many :products, through: :purchases
  has_many :stores, through: :products

# returns the top 5 highest spenders across all stores
  def self.most_valued_customers
    top_five_array = Product.joins(:purchases).group(:customer_id).order("SUM(price) DESC").limit(5).pluck(:customer_id)
    puts self.find(top_five_array).pluck(:name)
  end

  # returns the name and email of every customer across all stores
  def self.all_data
    Customer.all.collect do |customer|
      puts "#{customer.name} <#{customer.email}>"
    end
  end

end
