require_relative 'transaction'
require_relative 'transaction_loader'

class TransactionRepository
  attr_reader :filepath
  attr_accessor :transactions

  def initialize(filepath)
    @filepath = filepath
    @transactions = []
    load_data(filepath)
  end

  def load_data(filepath)
    transactions_csv = TransactionLoader.open_file(filepath)
    transactions_csv.each do |row|
      @transactions << Transaction.new(row[:id])
    end
  end

  def all
    @transactions
  end

  def random
    @transactions.sample
  end
end
