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

  def test_it_can_find_a_customer_by_id
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    customer = customer_repo.find_by_id(1)
    assert_equal customer.first_name, "Joey"
  end

  def test_it_can_find_a_different_customer_by_id
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    customer = customer_repo.find_by_id(3)
    assert_equal customer.first_name, "Mariah"
  end

  def test_it_can_find_a_customer_by_first_name
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    customer = customer_repo.find_by_first_name("Joey")
    assert_equal customer.id, 1
  end

  def test_it_can_find_a_different_customer_by_first_name
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    customer = customer_repo.find_by_first_name("Mariah")
    assert_equal customer.id, 3
  end

  def test_it_can_find_a_customer_by_first_name_regardless_of_case
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    customer = customer_repo.find_by_first_name("maRiAh")
    assert_equal customer.id, 3
  end

  def test_it_can_find_a_customer_by_last_name
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    customer = customer_repo.find_by_last_name("Ondricka")
    assert_equal customer.id, 1
  end

  def test_it_can_find_a_different_customer_by_last_name
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    customer = customer_repo.find_by_last_name("Toy")
    assert_equal customer.id, 3
  end

  def test_it_can_find_a_customer_by_last_name_regardless_of_case
    customer_repo = CustomerRepository.new("#{@path}/customers.csv")
    customer = customer_repo.find_by_last_name("tOY")
    assert_equal customer.id, 3
  end
end
