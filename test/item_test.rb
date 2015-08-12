require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test

  attr_reader :repository, :item, :other_item

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

    @other_item = Item.new({
      :id => 1830,
      :name => "Item Ut Ab",
      :description => "Quaerat autem illum quam dignissimos. Incidunt dolorum illum quas molestias maxime commodi. Provident sed unde praesentium itaque. Voluptatum exercitationem omnis deserunt error sed. Blanditiis accusamus in molestiae ipsam saepe quasi.",
      :unit_price => 1859,
      :merchant_id => 75,
      :created_at => "2012-03-27 14:54:07 UTC",
      :updated_at => "2012-03-27 14:54:07 UTC"
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

  def test_it_can_find_invoices_by_item
    result = item.invoices
    assert_equal result.size, 2
  end

  def test_it_can_find_successful_transactions
    result = item.successful_transactions
    other_result = other_item.successful_transactions
    assert_equal result.size, 0
    assert_equal other_result.size, 1
    assert_equal other_result[0].result, "success"
  end

  def test_it_can_find_successful_invoices
    result = item.successful_invoices
    other_result = other_item.successful_invoices
    assert_equal result.size, 0
    assert_equal other_result.size, 1
  end

  def test_it_can_find_successful_invoice_items
    result = other_item.successful_invoice_items
    assert_equal result.size, 1
  end

  def test_it_can_find_revenue_of_an_item
    result = other_item.revenue
    assert_equal result, 74.36
  end

  def test_it_can_find_the_total_sold_of_an_item
    result = item.total_items_sold
    other_result = other_item.total_items_sold
    assert_equal result, 0
    assert_equal other_result, 4
  end

  def test_it_can_find_invoice_dates
    result = item.invoice_dates
    assert_equal result.size, 2
    assert_equal result[0], Date.parse("2012-03-21")
  end
end
