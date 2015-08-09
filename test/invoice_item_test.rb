require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test

  attr_reader :invoice_item, :repository


  def setup
    sales_engine = SalesEngine.new("./test/fixtures")
    sales_engine.startup
    @repository = sales_engine.invoice_item_repository
    @invoice_item = InvoiceItem.new({
      :id => 1,
      :item_id => 539,
      :invoice_id => 1,
      :quantity => 5,
      :unit_price => 13635,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
      },
      repository)

  end

  def test_invoice_item_has_attributes
    assert_equal invoice_item.id, 1
  end

  def test_it_can_find_an_invoice_through_invoice_item
    result = invoice_item.invoice
    assert_equal result.customer_id, 1
  end

  def test_it_can_find_item_through_invoice_item
  result = invoice_item.item
  assert_equal result.name, "Item Sunt Saepe"

  end
end
