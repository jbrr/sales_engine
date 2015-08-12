require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  attr_reader :customer, :other_customer, :repository
  def setup
    sales_engine = SalesEngine.new('./test/fixtures')
    sales_engine.startup
    @repository = sales_engine.customer_repository
    @customer = Customer.new({
      :id => 1,
      :first_name => "Joey",
      :last_name => "Ondricka",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
      },
      repository)

      @other_customer = Customer.new({
        :id => 3,
        :first_name => "Mariah",
        :last_name => "Toy",
        :created_at => "2012-03-27 14:54:10 UTC",
        :updated_at => "2012-03-27 14:54:10 UTC"
        },
        repository)
  end

  def test_a_customer_has_attributes
      assert_equal customer.id, 1
      assert_equal customer.first_name, "Joey"
  end

  def test_it_can_find_invoices_by_customer
      result = customer.invoices
      assert_equal result.size, 3
  end

  def test_it_can_find_transactions_by_customer
      result = customer.transactions
      assert_equal result.size, 3
  end

  def test_it_can_find_successful_transactions
    result = customer.successful_transactions
    assert_equal result.size, 3
    assert_equal result[0].id, 1
    assert_equal result[0].result, "success"
  end

  def test_it_can_find_successful_invoices
    result = customer.successful_invoices
    assert_equal result.size, 3
    assert_equal result[0].id, 1
  end

  def test_it_can_find_successful_merchant_ids
    result = customer.successful_merchant_ids
    assert_equal result.size, 3
    assert_equal result[0], 26
  end

  def test_it_can_make_a_hash_of_merchant_ids_and_number_of_invoices
    result = customer.merchant_frequency_hash
    assert_equal result.size, 2
    assert_equal result, {26 => 2, 75 => 1}
  end

  def test_it_can_find_a_favorite_merchant_id
    result = customer.favorite_merchant_id
    assert_equal result, 26
  end

  def test_it_can_find_failed_transactions
    result = other_customer.failed_transactions
    assert_equal result[0].result, "failed"
  end

  def test_it_can_find_pending_transactions
    result = other_customer.pending_transactions
    assert_equal result.size, 1
    assert_equal result[0].id, 11
  end

  def test_it_can_find_pending_invoices
    assert_equal other_customer.pending_invoices[0].id, 12
  end
end
