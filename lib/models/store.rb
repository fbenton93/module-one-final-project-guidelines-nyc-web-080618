require 'pry'
class Store < ActiveRecord::Base
  has_many :store_products
  has_many :products, through: :store_products
  has_many :purchases, through: :products
  has_many :customers, through: :products

  # lists all categories
  def self.categories
    Product.pluck(:category).uniq
  end

  # returns all revenue from sales across all stores
  def self.aggregate_revenue
    Product.includes(:purchases).sum(:price)
  end

  # returns revenue for a specific store

  # currently failing: this  method is yet unable to discern individual
  # revenue because we can't distinguish purchases by store

  # options: 1: create a has_many reationship from store to purchases (favorable)
  # 2: create purchases through the Store class with a new attribute, 'store_id'
  # and save the creating-store's id to the purchase. (Option 2 will not allow
  # for the Store to know about its purchases though)

  def revenue
      Product.joins(:store_products, :purchases).where(store_products: {store_id: self.id}).sum(:price)
  end

  # does that mean this is failing?
  def local_customer_emails
    self.customers.pluck(:email)
  end

  def most_valued_customers
    top_five_array = Product.joins(:purchases, :store_products).where(store_products: {store_id: self.id}).group(:customer_id).order("SUM(price) DESC").limit(1).pluck(:customer_id)
    puts Customer.find(top_five_array).pluck(:name)
  end

end
