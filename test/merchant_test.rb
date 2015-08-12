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
    assert_equal merchant.created_at, Date.parse("2012-03-27 14:53:59 UTC")
    assert_equal merchant.updated_at, Date.parse("2012-03-27 14:53:59 UTC")
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
    assert_equal result[0].result, "success"
  end

  def test_it_can_find_invoices_of_successful_transactions
    result = merchant.successful_invoices
    assert_equal result.size, 1
  end

  def test_it_can_find_successful_invoice_items
    result = merchant.successful_invoice_items
    assert_equal result.size, 2
  end

  def test_it_can_find_successful_invoice_items_by_date
    result = merchant.successful_invoice_items_by_date(Date.parse("2012-03-27"))
    other_result = merchant.successful_invoice_items_by_date(Date.parse("2015-08-10"))
    assert_equal result.size, 2
    assert_equal other_result.size, 0
  end

  def test_it_returns_revenue_as_bigdecimal
    result = merchant.revenue
    assert_equal result.class, BigDecimal
  end

  def test_it_can_find_revenue_by_merchant
    result = merchant.revenue
    assert_equal result, 3639.76
  end

  def test_it_can_find_revenue_by_merchant_per_date
    result = merchant.revenue(Date.parse("2012-03-27"))
    other_result = merchant.revenue(Date.parse("2015-08-10"))
    assert_equal result, 3639.76
    assert_equal other_result, 0
  end

  def test_it_can_find_succesful_customer_ids
    result = merchant.successful_customer_ids
    assert_equal result.size, 1
    assert_equal result[0], 3
  end

  def test_it_can_make_a_hash_of_customer_ids_and_number_of_invoices
    result = merchant.customer_frequency_hash
    assert_equal result.size, 1
    assert_equal result, {3 => 1}
  end

  def test_it_can_find_favorite_customer_id
    result = merchant.favorite_customer_id
    assert_equal result, 3
  end

  def test_it_can_find_favorite_customer
    result = merchant.favorite_customer
    assert_equal result.id, 3
  end

  def test_it_can_find_failed_transactions
    result = merchant.failed_transactions
    assert_equal result[0].result, "failed"
  end

  def test_it_can_find_pending_transactions
    result = merchant.pending_transactions
    assert_equal result.size, 1
    assert_equal result[0].id, 11
  end

  def test_it_can_find_pending_invoices
    assert_equal merchant.pending_invoices[0].id, 12
  end

  def test_it_can_find_customers_with_pending_invoices
    assert_equal merchant.customers_with_pending_invoices[0].id, 3
  end
end
