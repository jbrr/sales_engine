require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @path = "./test/fixtures"
  end

  def test_it_stores_file_path
    transaction_repo = TransactionRepository.new("#{@path}/transactions.csv")
    assert_equal transaction_repo.filepath, "#{@path}/transactions.csv"
  end

  def test_transactions_array_is_populated
    transaction_repo = TransactionRepository.new("#{@path}/transactions.csv")
    refute transaction_repo.transactions.nil?
  end

  def test_it_has_10_elements
    transaction_repo = TransactionRepository.new("#{@path}/transactions.csv")
    assert_equal transaction_repo.transactions.size, 10
  end

  def test_it_can_return_all_instances_of_transactions
    transaction_repo = TransactionRepository.new("#{@path}/transactions.csv")
    assert_equal transaction_repo.transactions, transaction_repo.all
  end
end
