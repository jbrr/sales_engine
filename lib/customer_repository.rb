require_relative 'customer'
require_relative 'customer_loader'

class CustomerRepository
  attr_reader :filepath, :sales_engine
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

  def inspect
    "#<#{self.class} #{customers.size} rows"
  end

  def all
    customers
  end

  def random
    customers.sample
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

  def find_by_created_at(date)
    customers.find do |customer|
      customer.created_at == date
    end
  end

  def find_by_updated_at(date)
    customers.find do |customer|
      customer.updated_at == date
    end
  end

  def find_all_by_id(id)
    customers.find_all do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    customers.find_all do |customer|
      customer.first_name.downcase == first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    customers.find_all do |customer|
      customer.last_name.downcase == last_name.downcase
    end
  end

  def find_all_by_created_at(date)
    customers.find_all do |customer|
      customer.created_at == date
    end
  end

  def find_all_by_updated_at(date)
    customers.find_all do |customer|
      customer.updated_at == date
    end
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_customer(id)
  end

  def find_transactions(id)
    find_invoices(id).map do |invoice|
      sales_engine.find_transactions_by_invoice(invoice.customer_id)
    end
  end
end
