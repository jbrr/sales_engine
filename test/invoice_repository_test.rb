require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @path = "./test/fixtures"
  end

  def test_it_stores_file_path
    invoice_repo = InvoiceRepository.new("#{@path}/invoice.csv")
    assert_equal invoice_repo.filepath, "#{@path}/invoice.csv"
  end

  def test_invoice_array_is_populated
    invoice_repo = InvoiceRepository.new("#{@path}/invoice.csv")
    refute invoice_repo.invoice.nil?
  end

  def test_it_has_10_elements
    invoice_repo = InvoiceRepository.new("#{@path}/invoice.csv")
    assert_equal invoice_repo.invoice.size, 10
  end

  def test_it_can_return_all_instances_of_invoice
    invoice_repo = InvoiceRepository.new("#{@path}/invoice.csv")
    assert_equal invoice_repo.invoice, invoice_repo.all
  end
end
