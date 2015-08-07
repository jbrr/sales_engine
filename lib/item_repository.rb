require_relative 'item'
require_relative 'item_loader'

class ItemRepository
  attr_reader :filepath
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

  def all
    @items
  end

  def random
    @items.sample
  end

  [:id, :name, :description, :unit_price, :merchant_id, :created_at,
   :updated_at].each do |attribute|
     define_method "find_by_#{attribute}" do |arg|
       items.find do |item|
         item.send(attribute).to_s.downcase == arg.to_s.downcase
       end
     end
   end

   [:id, :name, :description, :unit_price, :merchant_id, :created_at,
    :updated_at].each do |attribute|
      define_method "find_all_by_#{attribute}" do |arg|
        items.find_all do |item|
          item.send(attribute).to_s.downcase == arg.to_s.downcase
        end
      end
    end
end
