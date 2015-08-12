require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test

  attr_reader :invoice, :repository

  def setup
    sales_engine = SalesEngine.new("./test/fixtures")
    sales_engine.startup
    @repository = sales_engine.invoice_repository
    @invoice = Invoice.new({
      :id => 1,
      :customer_id => 1,
      :merchant_id => 26,
      :status => "shipped",
      :created_at => "2012-03-25 09:54:09 UTC",
      :updated_at => "2012-03-25 09:54:09 UTC",
      },
      repository)
  end

  def test_an_invoice_instance_exists
    assert invoice
  end

  def test_an_invoice_has_attributes
    assert_equal invoice.id, 1
    assert_equal invoice.customer_id, 1
    assert_equal invoice.merchant_id, 26
    assert_equal invoice.status, "shipped"
    assert_equal invoice.created_at, Date.parse("2012-03-25 09:54:09 UTC")
    assert_equal invoice.updated_at, Date.parse("2012-03-25 09:54:09 UTC")
  end

  def test_it_can_find_all_transactions_by_invoice
    result = invoice.transactions
    assert_equal result.size, 1
  end

  def test_it_can_find_all_invoice_items_by_invoice
    result = invoice.invoice_items
    assert_equal result.size, 8
  end

  def test_it_can_find_all_invoice_items_by_invoice
    result = invoice.items
    assert_equal result.size, 8
  end

  def test_it_can_find_a_customer_by_invoice
    result = invoice.customer
    assert_equal result.first_name, "Joey"
  end

  def test_it_can_find_a_merchant_by_invoice
    result = invoice.merchant
    assert_equal result.name, "Balistreri, Schaefer and Kshlerin"
  end

  def test_it_can_create_a_transaction
    new_transaction = invoice.charge(credit_card_number: "4444333322221111",
               credit_card_expiration: "10/13", result: "success")
    assert_equal new_transaction.class, Transaction
    assert "we're done!"
  end
end
