require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'

class TransactionTest < Minitest::Test

  attr_reader :transaction, :repository

  def setup
    sales_engine = SalesEngine.new("./test/fixtures")
    sales_engine.startup
    @repository = sales_engine.transaction_repository
    @transaction = Transaction.new({
      :id => 1,
      :invoice_id => 1,
      :credit_card_number => "4654405418249632",
      :credit_card_expiration_date => "",
      :result => "success",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
      },
      repository)
  end

  def test_transaction_has_attributes
    assert_equal transaction.id, 1
  end

  def test_it_can_find_an_invoice_by_transaction
    result = transaction.invoice
    assert_equal result.merchant_id, 26
  end





end
