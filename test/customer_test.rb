require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  attr_reader :customer, :repository
  def setup
    sales_engine = SalesEngine.new('./test/fixtures')
    sales_engine.startup
    @repository = sales_engine.customer_repository
    @customer = Customer.new({
      :id => 1,
      :first_name => "Joey",
      :last_name => "Ondricka",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
      },
      repository)
    end

    def test_a_customer_has_attributes
      assert_equal customer.id, 1
      assert_equal customer.first_name, "Joey"
    end

    def test_it_can_find_invoices_by_customer
      result = customer.invoices
      assert_equal result.size, 2
    end
end
