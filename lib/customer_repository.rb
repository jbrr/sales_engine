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
    customer_csv = CustomerLoader.open_file(filepath)
    customer_csv.each do |row|
      @customers << Customer.new(row[:id])
    end
  end

  def all
    @customers
  end

  def random
    @customers.sample
  end
end
