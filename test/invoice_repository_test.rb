require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  attr_reader :invoice_repo, :customer, :merchant, :item

  def setup
    sales_engine = SalesEngine.new("./test/fixtures")
    sales_engine.startup
    @invoice_repo = sales_engine.invoice_repository
    @customer = Customer.new({
      :id => 1,
      :first_name => "Joey",
      :last_name => "Ondricka",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
      },
      sales_engine.customer_repository)
    @merchant = Merchant.new({
      :id => 8,
      :name => "Osinski, Pollich and Koelpin",
      :created_at => "2012-03-27 14:53:59 UTC",
      :updated_at => "2012-03-27 14:53:59 UTC"
      },
      sales_engine.merchant_repository)
    @item = Item.new({
      :id => 127,
      :name => "Item Ut Illum",
      :description => "Enim quae sit doloremque accusantium eaque amet quasi.
          Provident modi ipsum. Itaque voluptas quis non. In odio velit.",
      :merchant_id => 8,
      :unit_price => 41702,
      :created_at => "2012-03-27 14:53:59 UTC",
      :updated_at => "2012-03-27 14:53:59 UTC"
      },
      sales_engine.item_repository)
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

  def test_it_can_create_a_new_invoice
    new_invoice = invoice_repo.create({customer: customer, merchant: merchant,
      status: "shipped", items: [item]})
    assert_equal new_invoice.id, 14
  end
end
