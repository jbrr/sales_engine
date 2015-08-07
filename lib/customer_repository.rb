require_relative 'customer'
require_relative 'customer_loader'
require 'pry'

class CustomerRepository
  attr_reader :filepath
  attr_accessor :customers

  def initialize(filepath, sales_engine)
    @filepath = filepath
    @customers = []
    @sales_engine = sales_engine
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

  [:id, :first_name, :last_name, :created_at, :updated_at].each do |attribute|
    define_method "find_by_#{attribute}" do |arg|
      customers.find do |customer|
        customer.send(attribute).to_s.downcase == arg.to_s.downcase
      end
    end
  end

  [:id, :first_name, :last_name, :created_at, :updated_at].each do |attribute|
    define_method "find_all_by_#{attribute}" do |arg|
      customers.find_all do |customer|
        customer.send(attribute).to_s.downcase == arg.to_s.downcase
      end
    end
  end
end
