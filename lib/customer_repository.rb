require_relative 'customer_loader'

class CustomerRepository
  def initialize(filepath)
    @filepath = filepath
  end

  def load_data
    CustomerLoader.open_file(@filepath)
  end
end
