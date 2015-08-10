require_relative 'invoice_item'
require_relative 'invoice_item_loader'

class InvoiceItemRepository

  attr_reader :filepath, :sales_engine
  attr_accessor :invoice_items

  def initialize(filepath, sales_engine)
    @filepath = filepath
    @invoice_items = []
    @sales_engine = sales_engine
    load_data(filepath)
  end

  def load_data(filepath)
    InvoiceItemLoader.open_file(filepath).each do |row|
      invoice_items << InvoiceItem.new(row, self)
    end
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end


  def find_by_item_id(item_id)
    invoice_items.find do |item|
      item.item_id == item_id
    end
  end

  def find_by_invoice_id(invoice_id)
    invoice_items.find do |invoice|
      invoice.invoice_id == invoice_id
    end
  end

  def find_by_unit_price(unit_price)
    invoice_items.find do |price|
      price.unit_price == unit_price
    end
  end

  def find_by_created_at(created_at)
    invoice_items.find do |time|
      time.created_at == created_at
    end
  end

  def find_by_updated_at(updated_at)
    invoice_items.find do |time|
      time.updated_at == updated_at
    end
  end

  def find_by_quantity(quantity)
    invoice_items.find do |number|
      number.quantity == quantity
    end
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all do |item|
      item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all do |invoice|
      invoice.invoice_id == invoice_id
    end
  end

  def find_all_by_created_at(created_at)
    invoice_items.find_all do |time|
      time.created_at == created_at
    end
  end

  def find_all_by_updated_at(updated_at)
    invoice_items.find_all do |time|
      time.updated_at == updated_at
    end
  end

  def find_all_by_quantity(quantity)
    invoice_items.find_all do |number|
      number.quantity == quantity
    end
  end

  def find_all_items_by_invoice_id(invoice_id)
    invoice_items.find_all do |item|
      if item.invoice_id == invoice_id
        item.item_id
      end
    end
  end

  def find_invoice(invoice_id)
    sales_engine.find_invoice_by_invoice_item(invoice_id)
  end

  def find_item(item_id)
    sales_engine.find_item_by_invoice_item(item_id)
  end

end
