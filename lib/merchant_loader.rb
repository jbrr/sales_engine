require 'csv'

class MerchantLoader

  def self.open_file(file)
    CSV.open(file, headers: true, header_converters: :symbol)
  end

end
