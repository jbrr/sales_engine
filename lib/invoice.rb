require 'date'

class Invoice
  attr_reader :id, :customer_id, :merchant_id,
  :status, :created_at, :updated_at, :repository

  def initialize(row, repository)
    @id           = row[:id].to_i
    @customer_id  = row[:customer_id].to_i
    @merchant_id  = row[:merchant_id].to_i
    @status       = row[:status]
    @created_at   = Date.parse(row[:created_at])
    @updated_at   = Date.parse(row[:updated_at])
    @repository   = repository
  end

  def transactions
    repository.find_transactions(id)
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def items
    repository.find_items(id)
  end

  def customer
    repository.find_customer(customer_id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def charge(input)
    repository.create_transaction(input, id)
  end

  def successful_transactions
    transactions.find_all do |transaction|
      transaction.result == "success"
    end
  end

  def successful_transaction_inv_ids
    successful_transactions.map do |transaction|
      transaction.invoice_id
    end
  end

  def failed_transactions
    transactions.find_all do |transaction|
      transaction.result == "failed"
    end
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
end
