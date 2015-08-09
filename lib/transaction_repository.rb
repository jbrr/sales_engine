require_relative 'transaction'
require_relative 'transaction_loader'

class TransactionRepository
  attr_reader :filepath, :sales_engine
  attr_accessor :transactions

  def initialize(filepath, sales_engine)
    @filepath = filepath
    @transactions = []
    @sales_engine = sales_engine
    load_data(filepath)
  end

  def load_data(filepath)
    TransactionLoader.open_file(filepath).each do |row|
        @transactions << Transaction.new(row, self)
    end
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  def find_by_id(id)
    transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_by_invoice_id(invoice_id)
    transactions.find do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_by_credit_card_number(credit_card_number)
    transactions.find do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find do |transaction|
      transaction.credit_card_expiration_date == credit_card_expiration_date
    end
  end

  def find_by_result(result)
    transactions.find do |transaction|
      transaction.result == result
    end
  end

  def find_by_created_at(created_at)
    transactions.find do |transaction|
      transaction.created_at == created_at
    end
  end

  def find_by_updated_at(updated_at)
    transactions.find do |transaction|
      transaction.updated_at == updated_at
    end
  end

  def find_all_by_id(id)
    transactions.find_all do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    transactions.find_all do |transaction|
      transaction.credit_card_expiration_date == credit_card_expiration_date
    end
  end

  def find_all_by_result(result)
    transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def find_all_by_created_at(created_at)
    transactions.find_all do |transaction|
      transaction.created_at == created_at
    end
  end

  def find_all_by_updated_at(updated_at)
    transactions.find_all do |transaction|
      transaction.updated_at == updated_at
    end
  end

  def find_invoice(invoice_id)
    sales_engine.find_invoice_by_transaction(invoice_id)

  end
end
