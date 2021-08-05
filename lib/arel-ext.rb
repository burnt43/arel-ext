module Arel
  module Attributes
    class Attribute
      def to_node
        Arel::Nodes::Attribute.new(self)
      end
    end
  end 

  module Nodes
    class Ternary < Arel::Nodes::Node
      attr_reader :node1, :node2, :node3

      def initialize(node1, node2, node3)
        super()
        @node1 = node1
        @node2 = node2
        @node3 = node3
      end
    end

    # Add Additional Unary Node Classes
    %w[
      Attribute
    ].each do |name|
      const_set name, Class.new(Unary)
    end

    # Define Ternary Node Classes
    %w[
      If
    ].each do |name|
      const_set name, Class.new(Ternary)
    end
  end

  module Visitors
    class ToSql < Arel::Visitors::Reduce
      def visit_Arel_Nodes_Attribute(o, collector)
        attribute = o.expr
        table_name = attribute.relation.name
        attr_name = attribute.name

        collector << "`#{table_name}`.`#{attr_name}`"

        collector
      end

      def visit_Arel_Nodes_If(o, collector)
        collector << 'IF('
        visit o.node1, collector
        collector << ','
        visit o.node2, collector
        collector << ','
        visit o.node3, collector
        collector << ')'

        collector
      end
    end
  end
end
