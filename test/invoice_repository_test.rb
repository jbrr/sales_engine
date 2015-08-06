require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoice_repo

  def setup
    @invoice_repo = InvoiceRepository.new("./test/fixtures/invoices.csv", self)
  end

  def test_it_stores_file_path
    assert_equal invoice_repo.filepath, "./test/fixtures/invoices.csv"
  end

  def test_invoice_array_is_populated
    refute invoice_repo.invoice.nil?
  end

  def test_it_has_10_elements
    assert_equal invoice_repo.invoice.size, 3
  end

  def test_it_can_return_all_instances_of_invoice
    assert_equal invoice_repo.invoice, invoice_repo.all
  end
end
