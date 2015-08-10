require_relative 'merchant'
require_relative 'merchant_loader'

class MerchantRepository
  attr_reader :filepath, :sales_engine
  attr_accessor :merchants

  def initialize(filepath, sales_engine)
    @filepath = filepath
    @merchants = []
    @sales_engine = sales_engine
    load_data(filepath)
  end

  def load_data(filepath)
    MerchantLoader.open_file(filepath).each do |row|
      @merchants << Merchant.new(row, self)
    end
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_by_created_at(created_at)
    merchants.find do |merchant|
      merchant.created_at == created_at
    end
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_id(id)
    merchants.find_all do |merchant|
      merchant.id == id
    end
  end

  def find_all_by_created_at(time)
    merchants.find_all do |merchant|
      merchant.created_at == time
    end
  end

  def find_all_by_updated_at(time)
    merchants.find_all do |merchant|
      merchant.created_at == time
    end
  end

  def find_items(id)
    sales_engine.find_items_by_merchant(id)
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_merchant(id)
  end
end
