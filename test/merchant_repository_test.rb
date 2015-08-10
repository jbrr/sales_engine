require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :merchant_repo

  def setup
    sales_engine = SalesEngine.new("./test/fixtures")
    sales_engine.startup
    @merchant_repo = sales_engine.merchant_repository
  end

  def test_it_stores_file_path
    merchant_repo
    assert merchant_repo.filepath, "./test/fixtures/merchants.csv"
  end

  def test_merchants_array_is_populated
    refute merchant_repo.merchants.nil?
  end

  def test_it_has_10_elements
    assert_equal merchant_repo.merchants.size, 3
  end

  def test_it_can_return_all_instances_of_merchants
    assert_equal merchant_repo.merchants, merchant_repo.all
  end

  def test_merchant_can_find_by_id
    merchant = merchant_repo.find_by_id(8)
    assert_equal merchant.name, "Osinski, Pollich and Koelpin"
  end

  def test_merchant_can_find_by_name
    merchant = merchant_repo.find_by_name("Osinski, Pollich and Koelpin")
    assert_equal merchant.id, 8
  end

  def test_merchant_can_find_case_sensitive_name
    merchant = merchant_repo.find_by_name("OsiNski, PoLlich and koelpin")
    assert_equal merchant.id, 8
  end

  def test_merchant_can_find_by_created_at
    merchant = merchant_repo.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal merchant.id, 8
  end

  def test_merchant_can_find_all_by_name
    merchant_array = merchant_repo.find_all_by_name("Osinski, Pollich and Koelpin")
    assert_equal merchant_array.size, 1
  end

  def test_merchant_can_find_all_by_id
    merchant_array = merchant_repo.find_all_by_name("Osinski, Pollich and Koelpin")
    assert_equal merchant_array.size, 1
  end

  def test_merchant_can_find_all_by_created_at
    merchant_array = merchant_repo.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal merchant_array.size, 1
  end

  def test_it_can_rank_merchants_by_revenue
    result = merchant_repo.most_revenue(2)
    assert_equal result.size, 2
    assert_equal result[0].id, 26
  end

  def test_it_can_find_total_revenue_by_date
    result = merchant_repo.revenue("2012-03-27")
    other_result = merchant_repo.revenue("2015-08-10")
    assert_equal result, 29996.66
    assert_equal other_result, 0
  end
end
