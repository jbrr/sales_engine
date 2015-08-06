require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @path = "./test/fixtures"
  end

  def test_it_stores_file_path
    merchant_repo = MerchantRepository.new("#{@path}/merchants.csv")
    assert_equal merchant_repo.filepath, "#{@path}/merchants.csv"
  end

  def test_merchants_array_is_populated
    merchant_repo = MerchantRepository.new("#{@path}/merchants.csv")
    refute merchant_repo.merchants.nil?
  end

  def test_it_has_10_elements
    merchant_repo = MerchantRepository.new("#{@path}/merchants.csv")
    assert_equal merchant_repo.merchants.size, 10
  end

  def test_it_can_return_all_instances_of_merchants
    merchant_repo = MerchantRepository.new("#{@path}/merchants.csv")
    assert_equal merchant_repo.merchants, merchant_repo.all
  end
end
