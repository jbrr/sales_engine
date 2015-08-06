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
    merchants_csv = MerchantLoader.open_file(filepath)
    merchants_csv.each do |row|
      @merchants << Merchant.new(row[:id])
    end
  end

  def all
    @merchants
  end

  def random
    @merchants.sample
  end
end
