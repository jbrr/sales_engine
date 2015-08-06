require_relative 'item'
require_relative 'item_loader'

class ItemRepository
  attr_reader :filepath
  attr_accessor :items

  def initialize(filepath)
    @filepath = filepath
    @items = []
    load_data(filepath)
  end

  def load_data(filepath)
    items_csv = ItemLoader.open_file(filepath)
    items_csv.each do |row|
      @items << Item.new(row[:id])
    end
  end

  def all
    @items
  end

  def random
    @items.sample
  end
end
