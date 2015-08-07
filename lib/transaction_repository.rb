require_relative 'transaction'
require_relative 'transaction_loader'

class TransactionRepository
  attr_reader :filepath
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
    @transactions
  end

  def random
    @transactions.sample
  end

  [:id, :invoice_id, :credit_card_number, :credit_card_expiration_date,
   :result, :created_at, :updated_at].each do |attribute|
    define_method "find_by_#{attribute}".to_sym do |arg|
      transactions.find do |transaction|
        transaction.send(attribute) == arg
      end
    end
  end

  [:id, :invoice_id, :credit_card_number, :credit_card_expiration_date,
   :result, :created_at, :updated_at].each do |attribute|
    define_method "find_all_by_#{attribute}".to_sym do |arg|
      transactions.find_all do |transaction|
        transaction.send(attribute) == arg
      end
    end
  end
end
