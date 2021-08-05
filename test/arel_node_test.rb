require './test/initialize'

class ArelNodeTest < Arel::Testing::Test
  def test_attribute_node_to_sql
    table = Arel::Table.new('foos')
    attribute = table[:name]
    attribute_node = attribute.to_node

    assert_equal("`foos`.`name`", attribute_node.to_sql)
  end

  def test_foo
    table = Arel::Table.new('foos')
    if_node = Arel::Nodes::If.new(
      table[:age].gteq(30),
      table[:str].to_node,
      table[:dex].to_node
    )

    assert_equal(
      "IF(" \
        "`foos`.`age` >= 30," \
        "`foos`.`str`," \
        "`foos`.`dex`" \
      ")",
      if_node.to_sql
    )
  end
end
