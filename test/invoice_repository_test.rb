require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoice_repo

  def setup
    @invoice_repo = InvoiceRepository.new("./test/fixtures/invoices.csv", self)
  end

def test_it_can_find_an_invoice_by_id
	invoice = invoice_repo.find_by_id(1)
	assert_equal invoice.merchant_id, 26
end

def test_it_can_find_an_invoice_by_customer_id
	invoice = invoice_repo.find_by_customer_id(1)
	assert_equal invoice.merchant_id, 26
end

def test_it_can_find_an_invoice_by_merchant_id
	invoice = invoice_repo.find_by_merchant_id(26)
	assert_equal invoice.id, 1
end

def test_it_can_find_an_invoice_by_status
	invoice = invoice_repo.find_by_status("shipped")
	assert_equal invoice.id, 1
end

def test_it_can_find_an_invoice_by_created_at_date
	invoice = invoice_repo.find_by_created_at(Date.parse("2012-03-25 09:54:09 UTC"))
	assert_equal invoice.id, 1
end

def test_it_can_find_an_invoice_by_updated_at_date
	invoice = invoice_repo.find_by_updated_at(Date.parse("2012-03-25 09:54:09 UTC"))
	assert_equal invoice.id, 1
end

def test_it_can_find_all_by_id
	invoice = invoice_repo.find_all_by_id(1)
	assert_equal invoice.size, 1
end

def test_it_can_find_all_by_customer_id
	invoice = invoice_repo.find_all_by_customer_id(1)
	assert_equal invoice.size, 3
end

def test_it_can_find_all_by_merchant_id
	invoice = invoice_repo.find_all_by_merchant_id(26)
	assert_equal invoice.size, 2
end

def test_it_can_find_all_by_status
	invoice = invoice_repo.find_all_by_status("shipped")
	assert_equal invoice.size, 5
end

def test_it_can_find_all_by_created_at_date
	invoice = invoice_repo.find_all_by_created_at(Date.parse("2012-03-25 09:54:09 UTC"))
	assert_equal invoice.size, 1
end

def test_it_can_find_all_by_updated_at_date
	invoice = invoice_repo.find_all_by_updated_at(Date.parse("2012-03-25 09:54:09 UTC"))
	assert_equal invoice.size, 1
end

def test_it_will_return_an_empty_array_if_no_matches
	invoice = invoice_repo.find_all_by_id(4898437)
	assert_equal invoice.size, 0
end
end
