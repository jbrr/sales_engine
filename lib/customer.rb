require 'customer_loader'

class Customer

  attr_reader :customers

  def inititalize
    @customers = []
  end

  def load_data
    CSV.foreach('../data/customers.csv', headers: true, header_converters: :symbol) do |row|
      @customers << Customer.new(row)
  end
end
