require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test

  attr_reader :invoice_item_repo, :item, :other_item

  def setup
    sales_engine = SalesEngine.new("./test/fixtures")
    sales_engine.startup
    @invoice_item_repo = sales_engine.invoice_item_repository
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

    @other_item = Item.new({
      :id => 1830,
      :name => "Item Ut Ab",
      :description => "Quaerat autem illum quam dignissimos. Incidunt dolorum illum quas molestias maxime commodi. Provident sed unde praesentium itaque. Voluptatum exercitationem omnis deserunt error sed. Blanditiis accusamus in molestiae ipsam saepe quasi.",
      :unit_price => 1859,
      :merchant_id => 75,
      :created_at => "2012-03-27 14:54:07 UTC",
      :updated_at => "2012-03-27 14:54:07 UTC"
      },
      sales_engine.item_repository)
  end


  def test_it_stores_file_path
    assert_equal invoice_item_repo.filepath, "./test/fixtures/invoice_items.csv"
  end

  def test_invoice_item_array_is_populated
    refute invoice_item_repo.nil?
  end

  def test_it_has_correct_number_of_elements
    assert_equal invoice_item_repo.invoice_items.size, 20
  end

  def test_it_can_return_all_instances_of_invoice_items
    assert_equal invoice_item_repo.invoice_items, invoice_item_repo.invoice_items
  end

  def test_it_can_find_invoice_item_by_id
    invoice_item = invoice_item_repo.find_by_id(1)
    assert_equal invoice_item.item_id, 539
  end

  def test_it_can_find_invoice_items_by_item_id
    invoice_item = invoice_item_repo.find_by_item_id(539)
    assert invoice_item.id, 1
  end

  def test_can_find_invoice_items_by_invoice_id
    invoice_item = invoice_item_repo.find_by_invoice_id(1)
    assert invoice_item.id, 1
  end

  def test_it_can_find_by_unit_price
    invoice_item = invoice_item_repo.find_by_unit_price(136.35)
    assert invoice_item.id, 1
  end

  def test_it_can_find_by_created_at
    invoice_item = invoice_item_repo.find_by_created_at(Date.parse("2012-03-27 14:54:09 UTC"))
    assert invoice_item.id, 1
  end

  def test_it_can_find_by_updated_at
    invoice_item = invoice_item_repo.find_by_updated_at(Date.parse("2012-03-27 14:54:09 UTC"))
    assert invoice_item.id, 1
  end

  def test_it_can_find_by_quantity
    invoice_item = invoice_item_repo.find_by_quantity(5)
    assert invoice_item.id, 1
  end

  def test_it_can_find_all_invoice_items_by_id
    invoice_items = invoice_item_repo.find_all_by_id(1)
    assert_equal invoice_items.size, 1
  end

  def test_it_can_find_all_invoice_items_by_item_id
    invoice_item = invoice_item_repo.find_all_by_item_id(539)
    assert_equal invoice_item.size, 1
  end

  def test_can_find_all_invoice_items_by_invoice_id
    invoice_item = invoice_item_repo.find_all_by_invoice_id(1)
    assert_equal invoice_item.size, 8
  end

  def test_it_can_find_all_by_created_at
    invoice_item = invoice_item_repo.find_all_by_created_at(Date.parse("2012-03-27 14:54:09 UTC"))
    assert_equal invoice_item.size, 20
  end

  def test_it_can_find_all_by_updated_at
    invoice_item = invoice_item_repo.find_all_by_updated_at(Date.parse("2012-03-27 14:54:09 UTC"))
    assert_equal invoice_item.size, 20
  end

  def test_it_can_find_all_by_quantity
    invoice_item = invoice_item_repo.find_all_by_quantity(5)
    assert_equal invoice_item.size, 2
  end

  def test_it_can_create_invoice_items
    new_invoice_items = invoice_item_repo.create([item, other_item], 5)
    assert_equal invoice_item_repo.invoice_items[-1].id, 65
    assert_equal invoice_item_repo.invoice_items[-1].item_id, 1830
  end
end
