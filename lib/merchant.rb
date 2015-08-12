require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repository)
    @id         = row[:id].to_i
    @name       = row[:name]
    @created_at = Date.parse(row[:created_at])
    @updated_at = Date.parse(row[:updated_at])
    @repository = repository
  end

  def items
    repository.find_items(id)
  end

  def invoices
    repository.find_invoices(id)
  end

  def successful_transactions
    invoices.map do |invoice|
      invoice.transactions.find_all do |transaction|
        transaction.result == "success"
      end
    end.flatten
  end

  def successful_transaction_inv_ids
    successful_transactions.map do |transaction|
      transaction.invoice_id
    end
  end

  def failed_transactions
    invoices.map do |invoice|
      invoice.transactions.find_all do |transaction|
        transaction.result == "failed"
      end
    end.flatten
  end

  def pending_transactions
    failed_transactions.map do |transaction|
      unless successful_transaction_inv_ids.include?(transaction.invoice_id)
        transaction
      end
    end.flatten.compact
  end

  def pending_invoices
    pending_transactions.map do |transaction|
      transaction.invoice
    end
  end

  def customers_with_pending_invoices
    pending_invoices.map do |invoice|
      invoice.customer
    end
  end

  def successful_invoices
    successful_transactions.map do |transaction|
      transaction.invoice
    end
  end

  def successful_invoice_items
    successful_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten
  end

  def successful_invoice_items_by_date(date)
    successful_invoice_items.find_all do |invoice_item|
      invoice_item.invoice.created_at == date
    end
  end

  def successful_customer_ids
    successful_invoices.map do |invoice|
      invoice.customer_id
    end
  end

  def customer_frequency_hash
    successful_customer_ids.inject(Hash.new(0)) do |hash, customer_id|
      hash[customer_id] += 1; hash
    end
  end

  def favorite_customer_id
    customer_frequency_hash.max_by do |customer, frequency|
      frequency
    end[0]
  end

  def find_customer_by_customer_id(customer_id)
    repository.find_customer_by_customer_id(customer_id)
  end

  def favorite_customer
    find_customer_by_customer_id(favorite_customer_id)
  end

  def revenue(date = nil)
    if date
      relevant_invoice_items = successful_invoice_items_by_date(date)
    else
      relevant_invoice_items = successful_invoice_items
    end
    relevant_invoice_items.inject(0) do |result, invoice_item|
      (invoice_item.quantity * invoice_item.unit_price) + result
    end
  end

  def total_items_sold
    successful_invoice_items.inject(0) do |result, invoice_item|
      result + invoice_item.quantity
    end
  end
end
