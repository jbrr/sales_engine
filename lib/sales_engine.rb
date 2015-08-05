require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :customer_repository, :invoice_item_repository,
              :invoice_repository, :item_repository,
              :merchant_repository, :transaction_repository

  def inititalize

  end
  def startup
    @customer_repository
    @invoice_item_repository
    @invoice_repository
    @item_repository
    @merchant_repository
    @transaction_repository
  end

  def customer_repository
    @customer_repository = CustomerRepository.new
  end

  def invoice_item_repository
    @invoice_item_repository = InvoiceItemRepository.new
  end

  def invoice_repository
    @invoice_repository = InvoiceRepository.new
  end
  
  def item_repository
    @item_repository = ItemRepository.new
  end

  def merchant_repository
    @merchant_repository = MerchantRepository.new
  end

  def transaction_repository
    @transaction_repository = TransactionRepository.new
  end

end
