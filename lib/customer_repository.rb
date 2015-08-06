require_relative 'customer'
require_relative 'customer_loader'
require 'pry'

class CustomerRepository
  attr_reader :filepath
  attr_accessor :customers

  def initialize(filepath)
    @filepath = filepath
    @customers = []
    load_data(filepath)
  end

  def load_data(filepath)
   CustomerLoader.open_file(filepath).each do |row|
      @customers << Customer.new(row, self)
    end
  end

  def all
    @customers
  end

  def random
    @customers.sample
  end

  def find_by_id(id)
    customers.find do |customer|
      customer.id == id
    end
  end

  def find_by_first_name(first_name)
    customers.find do |customer|
      customer.first_name.downcase == first_name.downcase
    end
  end

  def find_by_last_name(last_name)
    customers.find do |customer|
      customer.last_name.downcase == last_name.downcase
    end
  end
end
