# frozen_string_literal: true

class PlantumlParser
  class Association < Parslet::Parser
    rule(:space) { match('\s').repeat(1) }
    rule(:space?) { space.maybe }

    rule(:left_association) { str('<--') }
    rule(:right_association) { str('-->') }

    rule(:association) { left_association | right_association }

    rule(:class_name) { match('[a-zA-Z]').repeat(1) }

    rule(:cardinality) { match('[0-9*"]').repeat(1) }

    rule(:expression) do
      space? >>
        class_name.as(:left_class) >>
        space? >>
        cardinality.maybe.as(:left_cardinality) >>
        space? >>
        association.as(:association) >>
        space? >>
        cardinality.maybe.as(:right_cardinality) >>
        space? >>
        class_name.as(:right_class)
    end

    root :expression
  end
end
