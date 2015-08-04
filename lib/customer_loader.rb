require 'csv'

class CustomerLoader

    def self.open_file(file)
      CSV.open(file, headers: true, header_converters: :symbol)
    end

end
