require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test

  attr_reader :repository, :item

  def setup
    sales_engine = SalesEngine.new("./test/fixtures")
    sales_engine.startup
    @repository = sales_engine.item_repository
    @item = Item.new({
      :id => 127,
      :name => "Item Ut Illum",
      :description => "Enim quae sit doloremque accusantium eaque amet quasi.
          Provident modi ipsum. Itaque voluptas quis non. In odio velit.",
      :merchant_id => 8,
      :unit_price => 41702,
      :created_at => "2012-03-27 14:53:59 UTC",
      :updated_at => "2012-03-27 14:53:59 UTC"
      },
      repository)
  end



  def test_item_has_attributes
    assert_equal item.id, 127
  end

  def test_it_can_find_invoice_items_by_item
    result = item.invoice_items
    assert_equal result.size, 2
  end

  def test_it_can_find_merchant_by_item
    result = item.merchant
    assert_equal result.name, "Osinski, Pollich and Koelpin"

  end


end
