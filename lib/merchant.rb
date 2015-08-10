class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repository)
    @id         = row[:id].to_i
    @name       = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @repository = repository
  end

  def items
    repository.find_items(id)
  end

  def invoices
    repository.find_invoices(id)
  end

  def successful_transactions
    successful_transactions = []
    invoices.each do |invoice|
      invoice.transactions.each do |transaction|
        if transaction.result == "success"
          successful_transactions << transaction
        end
      end
    end
    successful_transactions
  end

  def successful_invoices
    successful_invoices = successful_transactions.map do |transaction|
      transaction.invoice
    end
  end

  #returns an empty array within an empty array if no successful invoice items
  def successful_invoice_items
    result = []
    successful_invoices.each do |invoice|
      result = invoice.invoice_items
    end
    result
  end

  def revenue(date = nil)
    result = 0
    successful_invoice_items.each do |invoice_item|
      result = invoice_item.quantity * invoice_item.unit_price
    end
    result
  end
end
