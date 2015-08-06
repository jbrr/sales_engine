require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :customer_repository, :invoice_item_repository,
              :invoice_repository, :item_repository,
              :merchant_repository, :transaction_repository,
              :filepath

  def initialize(filepath)
    @filepath = filepath
  end
  def startup
  customer_repository_load
    @invoice_item_repository
    @invoice_repository
    @item_repository
    @merchant_repository
    @transaction_repository
  end

  def customer_repository_load
    @customer_repository = CustomerRepository.new("#{filepath}/customers.csv")
  end

  def invoice_item_repository
    @invoice_item_repository = InvoiceItemRepository.new("#{filepath}/invoice_item.csv")
  end

  def invoice_repository
    @invoice_repository = InvoiceRepository.new("#{filepath}/invoices.csv")
  end

  def item_repository
    @item_repository = ItemRepository.new("#{filepath}/items.csv")
  end

  def merchant_repository
    @merchant_repository = MerchantRepository.new("#{filepath}/merchants.csv")
  end

  def transaction_repository
    @transaction_repository = TransactionRepository.new("#{filepath}/transactions.csv")
  end

end
