require_relative 'item'
require_relative 'item_loader'

class ItemRepository
  attr_reader :filepath, :sales_engine
  attr_accessor :items

  def initialize(filepath, sales_engine)
    @filepath = filepath
    @items = []
    @sales_engine = sales_engine
    load_data(filepath)
  end

  def load_data(filepath)
    ItemLoader.open_file(filepath).each do |row|
      @items << Item.new(row, self)
    end
  end

  def inspect
    "#<#{self.class} #{items.size} rows"
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by_id(id)
    items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_by_description(description)
    items.find do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_by_unit_price(price)
    items.find do |item|
      item.unit_price == price
    end
  end

  def find_by_merchant_id(merchant_id)
    items.find do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_by_created_at(created_at)
    items.find do |item|
      item.created_at == created_at
    end
  end

  def find_by_updated_at(updated_at)
    items.find do |item|
      item.updated_at == updated_at
    end
  end

  def find_all_by_id(id)
    items.find_all do |item|
      item.id == id
    end
  end

  def find_all_by_name(name)
    items.find_all do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_by_description(description)
    items.find_all do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_all_by_unit_price(price)
    items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_all_by_created_at(created_at)
    items.find_all do |item|
      item.created_at == created_at
    end
  end

  def find_all_by_updated_at(updated_at)
    items.find_all do |item|
      item.updated_at == updated_at
    end
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_item(id)
  end

  def find_merchant(merchant_id)
    sales_engine.find_merchant_by_item(merchant_id)
  end

  def most_revenue(num)
    items.max_by(num) do |item|
      item.revenue
    end
  end

  def most_items(num)
    items.max_by(num) do |item|
      item.total_items_sold
    end
  end
end
