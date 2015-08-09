require_relative 'invoice'
require_relative 'invoice_loader'
require 'pry'

class InvoiceRepository

  attr_reader :filepath, :sales_engine
  attr_accessor :invoices

  def initialize(filepath, sales_engine)
    @filepath = filepath
    @invoices = []
    @sales_engine = sales_engine
    load_data(filepath)
  end

  def load_data(filepath)
    invoice_csv = InvoiceLoader.open_file(filepath)
    invoice_csv.each do |row|
      @invoices << Invoice.new(row, self)
    end
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_by_customer_id(customer_id)
    invoices.find do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_by_merchant_id(merchant_id)
    invoices.find do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_by_status(status)
    invoices.find do |invoice|
      invoice.status == status
    end
  end

  def find_by_created_at(created_at)
    invoices.find do |time|
      time.created_at == created_at
    end
  end

  def find_by_updated_at(updated_at)
    invoices.find do |invoice|
      invoice.updated_at == updated_at
    end
  end

  def find_all_by_id(id)
    invoices.find_all do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_all_by_created_at(created_at)
    invoices.find_all do |time|
      time.created_at == created_at
    end
  end

  def find_all_by_updated_at(updated_at)
    invoices.find_all do |time|
      time.updated_at == updated_at
    end
  end

  def find_transactions(id)
    sales_engine.find_transactions_by_invoice(id)
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_invoice(id)
  end

  def find_items(id)
    sales_engine.find_items_by_invoice(id)
  end

  def find_customer(customer_id)
    sales_engine.find_customer_by_invoice(customer_id)
  end

  def find_merchant(merchant_id)
    sales_engine.find_merchant_by_invoice(merchant_id)
  end
end
