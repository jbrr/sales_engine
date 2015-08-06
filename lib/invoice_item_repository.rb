require_relative 'invoice_item'
require_relative 'invoice_item_loader'
require 'pry'

class InvoiceItemRepository

  attr_reader :filepath
  attr_accessor :invoice_item

  def initialize(filepath)
    @filepath = filepath
    @invoice_item = []
    load_data(filepath)
  end

  def load_data(filepath)
    invoice_item_csv = InvoiceItemLoader.open_file(filepath)
    invoice_item_csv.each do |row|
      @invoice_item << InvoiceItem.new(row[:id])
    end
  end

  def all
    @invoice_item
  end

  def random
    @invoice_item.sample
  end
end
