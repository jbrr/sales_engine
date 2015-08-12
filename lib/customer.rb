require 'date'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(row, repository)
    @id         = row[:id].to_i
    @first_name = row[:first_name]
    @last_name  = row[:last_name]
    @created_at = Date.parse(row[:created_at])
    @updated_at = Date.parse(row[:updated_at])
    @repository = repository
  end

  def invoices
    repository.find_invoices(id)
  end

  def transactions
    repository.find_transactions(id)
  end

  def successful_transactions
    transactions.find_all do |transaction|
      transaction.result == "success"
    end
  end

  def successful_invoices
    successful_transactions.map do |transaction|
      transaction.invoice
    end
  end

  def successful_merchant_ids
    successful_invoices.map do |invoice|
      invoice.merchant_id
    end
  end

  def merchant_frequency_hash
    successful_merchant_ids.inject(Hash.new(0)) do |hash, merchant_id|
      hash[merchant_id] += 1; hash
    end
  end

  def favorite_merchant_id
    merchant_frequency_hash.max_by do |merchant, frequency|
      frequency
    end[0]
  end

  def find_merchant_by_merchant_id(merchant_id)
    repository.find_merchant_by_merchant_id(merchant_id)
  end

  def favorite_merchant
    find_merchant_by_merchant_id(favorite_merchant_id)
  end
end
