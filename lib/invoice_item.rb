require 'bigdecimal'
require 'date'

class InvoiceItem

  attr_reader :id, :item_id, :invoice_id,
              :quantity, :unit_price, :created_at,
              :updated_at, :repository
  def initialize(row, repository)
    @id         = row[:id].to_i
    @item_id    = row[:item_id].to_i
    @invoice_id = row[:invoice_id].to_i
    @quantity   = row[:quantity].to_i
    @unit_price = BigDecimal.new(row[:unit_price]) / 100
    @created_at = Date.parse(row[:created_at])
    @updated_at = Date.parse(row[:updated_at])
    @repository = repository
  end


  def invoice
    repository.find_invoice(invoice_id)
  end

  def item
    repository.find_item(item_id)
  end
end
