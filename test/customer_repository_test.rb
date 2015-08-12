require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repo

  def setup
    @customer_repo = CustomerRepository.new("./test/fixtures/customers.csv", self)
  end

  def test_it_stores_file_path
    assert_equal customer_repo.filepath, "./test/fixtures/customers.csv"
  end

  def test_customers_array_is_populated
    refute customer_repo.customers.nil?
  end

  def test_it_has_correct_number_of_elements
    assert_equal customer_repo.customers.size, 2
  end

  def test_it_can_return_all_instances_of_customers
    assert_equal customer_repo.customers, customer_repo.all
  end

  def test_it_can_find_a_customer_by_id
    customer = customer_repo.find_by_id(1)
    assert_equal customer.first_name, "Joey"
  end

  def test_it_can_find_a_different_customer_by_id
    customer = customer_repo.find_by_id(3)
    assert_equal customer.first_name, "Mariah"
  end

  def test_it_can_find_a_customer_by_first_name
    customer = customer_repo.find_by_first_name("Joey")
    assert_equal customer.id, 1
  end

  def test_it_can_find_a_different_customer_by_first_name
    customer = customer_repo.find_by_first_name("Mariah")
    assert_equal customer.id, 3
  end

  def test_it_can_find_a_customer_by_first_name_regardless_of_case
    customer = customer_repo.find_by_first_name("maRiAh")
    assert_equal customer.id, 3
  end

  def test_it_can_find_a_customer_by_last_name
    customer = customer_repo.find_by_last_name("Ondricka")
    assert_equal customer.id, 1
  end

  def test_it_can_find_a_different_customer_by_last_name
    customer = customer_repo.find_by_last_name("Toy")
    assert_equal customer.id, 3
  end

  def test_it_can_find_a_customer_by_last_name_regardless_of_case
    customer = customer_repo.find_by_last_name("tOY")
    assert_equal customer.id, 3
  end

  def test_it_can_find_a_customer_by_created_at_date
    customer = customer_repo.find_by_created_at(Date.parse("2012-03-27 14:54:09 UTC"))
    assert_equal customer.id, 1
  end

  def test_it_can_find_a_customer_by_updated_at_date
    customer = customer_repo.find_by_updated_at(Date.parse("2012-03-27 14:54:10 UTC"))
    assert_equal customer.id, 1
  end

  def test_it_can_find_all_by_id
    customer_array = customer_repo.find_all_by_id(1)
    assert_equal customer_array.size, 1
  end

  def test_it_can_find_all_by_first_name
    customer_array = customer_repo.find_all_by_first_name("Joey")
    assert_equal customer_array.size, 1
  end

  def test_it_can_find_all_by_last_name
    customer_array = customer_repo.find_all_by_last_name("Toy")
    assert_equal customer_array.size, 1
  end

  def test_it_can_find_all_by_created_at_date
    customer_array = customer_repo.find_all_by_created_at(Date.parse("2012-03-27 14:54:09 UTC"))
    assert_equal customer_array.size, 2
  end

  def test_it_can_find_all_by_updated_at_date
    customer_array = customer_repo.find_all_by_updated_at(Date.parse("2012-03-27 14:54:09 UTC"))
    assert_equal customer_array.size, 2
  end

  def test_it_will_return_an_empty_array_if_no_matches
    customer_array = customer_repo.find_all_by_id(45893)
    assert_equal customer_array.size, 0
  end
end
