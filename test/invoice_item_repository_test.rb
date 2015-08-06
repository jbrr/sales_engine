require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @path = "./test/fixtures"
  end

  def test_it_stores_file_path
    invoice_repo = InvoiceItemRepository.new("#{@path}/invoice_item.csv")
    assert_equal invoice_repo.filepath, "#{@path}/invoice_item.csv"
  end

  def test_invoice_item_array_is_populated
    invoice_repo = InvoiceItemRepository.new("#{@path}/invoice_item.csv")
    refute invoice_repo.invoice_item.nil?
  end

  def test_it_has_10_elements
    invoice_repo = InvoiceItemRepository.new("#{@path}/invoice_item.csv")
    assert_equal invoice_repo.invoice_item.size, 10
  end

  def test_it_can_return_all_instances_of_invoice_items
    invoice_repo = InvoiceItemRepository.new("#{@path}/invoice_item.csv")
    assert_equal invoice_repo.invoice_item, invoice_repo.all
  end
end
