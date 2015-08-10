require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
  attr_reader :merchant, :repository

  def setup
    sales_engine = SalesEngine.new("./test/fixtures")
    sales_engine.startup
    @repository = sales_engine.merchant_repository
    @merchant = Merchant.new({
      :id => 8,
      :name => "Osinski, Pollich and Koelpin",
      :created_at => "2012-03-27 14:53:59 UTC",
      :updated_at => "2012-03-27 14:53:59 UTC"
      },
      repository)
  end

  def test_a_merchant_instance_exists
    assert merchant
  end

  def test_a_merchant_has_attributes
    assert_equal merchant.id, 8
    assert_equal merchant.name, "Osinski, Pollich and Koelpin"
    assert_equal merchant.created_at, "2012-03-27 14:53:59 UTC"
    assert_equal merchant.updated_at, "2012-03-27 14:53:59 UTC"
  end

  def test_it_can_find_all_items_by_merchant
    result = merchant.items
    assert_equal result.size, 5
  end

  def test_it_can_find_all_invoices_by_merchant
    result = merchant.invoices
    assert_equal result.size, 2
  end

  def test_it_can_find_successful_transactions_of_a_merchant
    result = merchant.successful_transactions
    assert_equal result.size, 1
  end

  def test_it_can_find_invoices_of_successful_transactions
    result = merchant.successful_invoices
    assert_equal result.size, 1
  end

  def test_it_can_find_successful_invoice_items
    result = merchant.successful_invoice_items
    assert_equal result.size, 1
  end

  def test_it_can_find_revenue_by_merchant
    result = merchant.revenue
    assert_equal result, 901.84
  end
end
