require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @path = "./test/fixtures"
  end

  def test_it_stores_file_path
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    assert_equal customer_repo.filepath, "#{@path}/customers.csv"
  end

  def test_customers_array_is_populated
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    refute customer_repo.customers.nil?
  end

  def test_it_has_10_elements
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    assert_equal customer_repo.customers.size, 2
  end

  def test_it_can_return_all_instances_of_customers
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    assert_equal customer_repo.customers, customer_repo.all
  end
end
