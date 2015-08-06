require_relative 'merchant'
require_relative 'merchant_loader'

class MerchantRepository
  attr_reader :filepath
  attr_accessor :merchants

  def initialize(filepath)
    @filepath = filepath
    @merchants = []
    load_data(filepath)
  end

  def load_data(filepath)

    MerchantLoader.open_file(filepath).each do |row|
      @merchants << Merchant.new(row, self)
    end
  end

  def all
    @merchants
  end

  def random
    @merchants.sample
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
  end
end
