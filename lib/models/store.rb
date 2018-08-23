require 'pry'
class Store < ActiveRecord::Base
  has_many :store_products
  has_many :products, through: :store_products
  has_many :purchases, through: :products
  has_many :customers, through: :products


  def self.categories
    Product.pluck(:category).uniq
  end

  def self.aggregate_revenue
    Product.includes(:purchases).sum(:price)
  end

  def revenue
      Product.joins(:purchases, :stores).where(stores: {id: self.id}).sum(:price)
  end

  def local_customer_emails
    self.customers.pluck(:email)
  end

  def most_valued_customers
    top_five_array = Product.joins(:purchases, :store_products).where(store_products: {store_id: self.id}).group(:customer_id).order("SUM(price) DESC").limit(1).pluck(:customer_id)
    puts Customer.find(top_five_array).pluck(:name)
  end

end