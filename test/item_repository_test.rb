require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repo

  def setup
    @item_repo = ItemRepository.new("./test/fixtures/items.csv", self)
  end

  def test_it_stores_file_path
    assert_equal item_repo.filepath, "./test/fixtures/items.csv"
  end

  def test_items_array_is_populated
    refute item_repo.items.nil?
  end

  def test_it_has_the_correct_number_of_elements
    assert_equal item_repo.items.size, 18
  end

  def test_it_can_return_all_instances_of_items
    assert_equal item_repo.items, item_repo.all
  end

  def test_it_can_find_items_by_id
    item = item_repo.find_by_id(127)
    assert_equal item.name, "Item Ut Illum"
  end

  def test_it_can_find_an_item_by_name
    item = item_repo.find_by_name("Item Ut Illum")
    assert_equal item.id, 127
  end

  def test_it_can_find_an_item_by_name_regardless_of_case
    item = item_repo.find_by_name("item UT ILLum")
    assert_equal item.id, 127
  end

  def test_it_can_find_an_item_by_description
    item = item_repo.find_by_description("Cool Stuff")
    assert_equal item.id, 1
  end

  def test_it_can_find_an_item_by_description_regardless_of_case
    item = item_repo.find_by_description("COOL stuff")
    assert_equal item.id, 1
  end

  def test_it_can_find_an_item_by_unit_price
    item = item_repo.find_by_unit_price(417.02)
    assert_equal item.id, 127
  end

  def test_it_can_find_an_item_by_merchant_id
    item = item_repo.find_by_merchant_id(8)
    assert_equal item.id, 127
  end

  def test_it_can_find_an_item_by_created_at_date
    item = item_repo.find_by_created_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal item.id, 127
  end

  def test_it_can_find_an_item_by_updated_at_date
    item = item_repo.find_by_updated_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal item.id, 127
  end

  def test_it_can_find_all_item_by_id
    items = item_repo.find_all_by_id(127)
    assert_equal items.size, 1
  end

  def test_it_can_find_all_items_by_name
    items = item_repo.find_all_by_name("Item Ut Illum")
    assert_equal items.size, 1
  end

  def test_it_can_find_all_items_by_description
    items = item_repo.find_all_by_description("cool stuff")
    assert_equal items.size, 1
  end

  def test_it_can_find_all_items_by_unit_price
    items = item_repo.find_all_by_unit_price(417.02)
    assert_equal items.size, 1
  end

  def test_it_can_find_all_items_by_merchant_id
    items = item_repo.find_all_by_merchant_id(8)
    assert_equal items.size, 5
  end

  def test_it_can_find_all_by_created_at_date
    items = item_repo.find_all_by_created_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal items.size, 17
  end

  def test_it_can_find_all_items_by_updated_at_date
    items = item_repo.find_all_by_updated_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal items.size, 17
  end

  def test_it_will_return_an_empty_array_if_no_matches
    items = item_repo.find_all_by_id(574934)
    assert_equal items.size, 0
  end

  def test_it_will_find_most_sales_on_a_given_date
    items = item.repo.most_sales
    assert_equal items.size, 1
    
  end
end
