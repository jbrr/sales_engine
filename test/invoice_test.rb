require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test

  attr_reader :invoice

  def setup
    @invoice = Invoice.new("./test/fixtures/invoices.csv", self)
  end

  def test_it_stores_file_path
    assert_equal invoice.filepath, "./test/fixtures/invoice.csv"
  end

end
