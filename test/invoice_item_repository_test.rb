require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  attr_reader :invoice_item_repo

  def setup
    @invoice_item_repo = InvoiceItemRepository.new("./test/fixtures/invoice_items.csv", self)
  end


  def test_it_stores_file_path
    assert_equal invoice_item_repo.filepath, "./test/fixtures/invoice_items.csv"
  end

  def test_invoice_item_array_is_populated
    refute invoice_item_repo.nil?
  end

  def test_it_has_correct_number_of_elements
    assert_equal invoice_item_repo.invoice_items.size, 18
  end

  def test_it_can_return_all_instances_of_invoice_items
    assert_equal invoice_item_repo.invoice_items, invoice_item_repo.invoice_items
  end

  def test_it_can_find_invoice_items_by_item_id
    invoice_item = invoice_item_repo.find_by_item_id(539)
    assert invoice_item.id, 1
  end

  def test_can_find_invoice_items_by_invoice_id
    invoice_item = invoice_item_repo.find_by_invoice_id(1)
    assert invoice_item.id, 1
  end

  def test_it_can_find_by_unit_price
    invoice_item = invoice_item_repo.find_by_unit_price(136.35)
    assert invoice_item.id, 1
  end

  def test_it_can_find_by_created_at
    invoice_item = invoice_item_repo.find_by_created_at('2012-03-27 14:54:09 UTC')
    assert invoice_item.id, 1
  end

  def test_it_can_find_by_updated_at
    invoice_item = invoice_item_repo.find_by_updated_at('2012-03-27 14:54:09 UTC')
    assert invoice_item.id, 1
  end

  def test_it_can_find_by_quantity
    invoice_item = invoice_item_repo.find_by_quantity(5)
    assert invoice_item.id, 1
  end

  def test_it_can_find_all_invoice_items_by_item_id
    invoice_item = invoice_item_repo.find_all_by_item_id(539)
    assert_equal invoice_item.size, 1
  end

  def test_can_find_all_invoice_items_by_invoice_id
    invoice_item = invoice_item_repo.find_all_by_invoice_id(1)
    assert_equal invoice_item.size, 8
  end


  def test_it_can_find_all_by_created_at
    invoice_item = invoice_item_repo.find_all_by_created_at('2012-03-27 14:54:09 UTC')
    assert_equal invoice_item.size, 12
  end

  def test_it_can_find_all_by_updated_at
    invoice_item = invoice_item_repo.find_all_by_updated_at('2012-03-27 14:54:09 UTC')
    assert_equal invoice_item.size, 12
  end

  def test_it_can_find_all_by_quantity
    invoice_item = invoice_item_repo.find_all_by_quantity(5)
    assert_equal invoice_item.size, 2
  end




end
