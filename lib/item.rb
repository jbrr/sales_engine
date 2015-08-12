require 'bigdecimal'
require 'date'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repository)
    @id           = row[:id].to_i
    @name         = row[:name]
    @description  = row[:description]
    @unit_price   = BigDecimal.new(row[:unit_price]) / 100
    @merchant_id  = row[:merchant_id].to_i
    @created_at   = Date.parse(row[:created_at])
    @updated_at   = Date.parse(row[:updated_at])
    @repository   = repository
  end

  def invoice_items
    repository.find_invoice_items(id)

  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def invoices
    invoice_items.map do |invoice_item|
      invoice_item.invoice
    end
  end

  def successful_transactions
    invoices.map do |invoice|
      invoice.transactions.find_all do |transaction|
        transaction.result == "success"
      end
    end.flatten
  end

  def successful_invoices
    successful_transactions.map do |transaction|
      transaction.invoice
    end
  end

  def successful_invoice_items
    successful_invoices.map do |invoice|
      invoice.invoice_items.find_all do |invoice_item|
        invoice_item.item_id == id
      end
    end.flatten
  end

  def revenue
    invoice_items.inject(0) do |result, invoice_item|
      (invoice_item.quantity * invoice_item.unit_price) + result
    end
  end

  def total_items_sold
    successful_invoice_items.inject(0) do |result, invoice_item|
      result + invoice_item.quantity
    end
  end
end
