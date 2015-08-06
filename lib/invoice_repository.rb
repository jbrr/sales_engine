require_relative 'invoice'
require_relative 'invoice_loader'
require 'pry'

class InvoiceRepository

  attr_reader :filepath
  attr_accessor :invoice

  def initialize(filepath)
    @filepath = filepath
    @invoice = []
    load_data(filepath)
  end

  def load_data(filepath)
    invoice_csv = InvoiceLoader.open_file(filepath)
    invoice_csv.each do |row|
      @invoice << Invoice.new(row[:id])
    end
  end

  def all
    @invoice
  end

  def random
    @invoice.sample
  end
end
