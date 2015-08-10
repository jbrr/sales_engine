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

  def successful_invoice_items
    result = []
    successful_invoices.each do |invoice|
      result = invoice.invoice_items
    end
    result
  end

  def successful_invoice_items_by_date(date)
    successful_invoice_items.find_all do |invoice_item|
      invoice_item.created_at[0..9] == date[0..9]
    end
  end

  def revenue(date = nil)
    if date
      relevant_invoice_items = successful_invoice_items_by_date(date)
    else
      relevant_invoice_items = successful_invoice_items
    end
    relevant_invoice_items.inject(0) do |result, invoice_item|
      invoice_item.quantity * invoice_item.unit_price + result
    end
  end
end
