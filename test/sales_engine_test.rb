require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_can_instantiate_new_depositories
    engine = SalesEngine.new("./test/fixtures")
    engine.startup

    assert engine.customer_repository.kind_of?(CustomerRepository)
    assert engine.invoice_item_repository.kind_of?(InvoiceItemRepository)
    assert engine.invoice_repository.kind_of?(InvoiceRepository)
    assert engine.item_repository.kind_of?(ItemRepository)
    assert engine.merchant_repository.kind_of?(MerchantRepository)
    assert engine.transaction_repository.kind_of?(TransactionRepository)
  end
end
