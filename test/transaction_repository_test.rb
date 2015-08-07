require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repo

  def setup
    @transaction_repo = TransactionRepository.new("./test/fixtures/transactions.csv", self)
  end

  def test_it_stores_file_path
    assert_equal transaction_repo.filepath, "./test/fixtures/transactions.csv"
  end

  def test_transactions_array_is_populated
    refute transaction_repo.transactions.nil?
  end

  def test_it_has_correct_number_of_elements
    assert_equal transaction_repo.transactions.size, 3
  end

  def test_it_can_return_all_instances_of_transactions
    assert_equal transaction_repo.transactions, transaction_repo.all
  end

  def test_it_can_find_a_transaction_by_id
    transaction = transaction_repo.find_by_id(1)
    assert_equal transaction.invoice_id, 1
  end

  def test_it_can_find_a_transaction_by_invoice_id
    transaction = transaction_repo.find_by_invoice_id(1)
    assert_equal transaction.id, 1
  end

  def test_it_can_find_a_transaction_by_credit_card_number
    transaction = transaction_repo.find_by_credit_card_number("4800749911485986")
    assert_equal transaction.id, 11
  end

  def test_it_can_find_a_transaction_by_credit_card_expiration_date
    transaction = transaction_repo.find_by_credit_card_expiration_date("0815")
    assert_equal transaction.id, 2
  end

  def test_it_can_find_a_transaction_by_result
    transaction = transaction_repo.find_by_result("success")
    assert_equal transaction.id, 1
  end

  def test_it_can_find_a_transaction_by_created_at_date
    transaction = transaction_repo.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal transaction.id, 1
  end

  def test_it_can_find_a_transaction_by_updated_at_date
    transaction = transaction_repo.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal transaction.id, 1
  end

  def test_it_can_find_all_transactions_by_id
    transactions = transaction_repo.find_all_by_id(1)
    assert_equal transactions.size, 1
  end

  def test_it_can_find_all_transactions_by_invoice_id
    transactions = transaction_repo.find_all_by_invoice_id(2)
    assert_equal transactions.size, 1
  end

  def test_it_can_find_all_transactions_by_credit_card_number
    transactions = transaction_repo.find_all_by_credit_card_number("4580251236515201")
    assert_equal transactions.size, 1
  end

  def test_it_can_find_all_transactions_by_credit_card_expiration_date
    transactions = transaction_repo.find_all_by_credit_card_expiration_date("0815")
    assert_equal transactions.size, 2
  end

  def test_it_can_find_all_transactions_by_result
    transactions = transaction_repo.find_all_by_result("success")
    assert_equal transactions.size, 2
  end

  def test_it_can_find_all_transactions_by_created_at_date
    transactions = transaction_repo.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal transactions.size, 2
  end

  def test_it_can_find_all_transactions_by_updated_at_date
    transactions = transaction_repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal transactions.size, 2
  end

  def test_it_will_return_an_empty_array_if_no_matches
    transactions = transaction_repo.find_all_by_id(385974)
    assert_equal transactions.size, 0
  end
end
