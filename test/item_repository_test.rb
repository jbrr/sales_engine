require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @path = "./test/fixtures"
  end

  def test_it_stores_file_path
    item_repo = ItemRepository.new("#{@path}/items.csv")
    assert_equal item_repo.filepath, "#{@path}/items.csv"
  end

  def test_items_array_is_populated
    item_repo = ItemRepository.new("#{@path}/items.csv")
    refute item_repo.items.nil?
  end

  def test_it_has_10_elements
    item_repo = ItemRepository.new("#{@path}/items.csv")
    assert_equal item_repo.items.size, 10
  end

  def test_it_can_return_all_instances_of_items
    item_repo = ItemRepository.new("#{@path}/items.csv")
    assert_equal item_repo.items, item_repo.all
  end
end
