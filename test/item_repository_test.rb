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

  def test_it_has_10_elements
    assert_equal item_repo.items.size, 17
  end

  def test_it_can_return_all_instances_of_items
    assert_equal item_repo.items, item_repo.all
  end
end
