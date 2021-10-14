# frozen_string_literal: true

require 'parslet'
require 'amazing_print'

file = File.read(File.join('./docs', 'test.md'))

classes_collection = file.scan(/class\s[a-zA-Z\s<>_]*\s{[^}]*}/)

ap classes_collection

puts "\n"

puts classes_collection.first
# p file

puts "\n"

class MiniP < Parslet::Parser
  # Things
  # rule(:integer)    { match('[0-9]').repeat(1).as(:int) >> space? }
  # rule(:operator)   { match('[+]') >> space? }

  # Grammar parts
  # rule(:sum)        do
  #   integer.as(:left) >> operator.as(:op) >> expression.as(:right)
  # end
  # rule(:arglist)    { expression >> (comma >> expression).repeat }
  # rule(:funcall)    do
  #   identifier.as(:funcall) >> lparen >> arglist.as(:arglist) >> rparen
  # end

  rule(:space) { match('\s').repeat(1) }
  rule(:space?) { space.maybe }

  rule(:new_line) { match('\n').repeat(1) }
  rule(:new_line?) { new_line.maybe }

  rule(:lparen) { str('{') }
  rule(:rparen) { str('}') }

  rule(:class_keyword) { str('class') }
  rule(:class_name) { match('[a-zA-Z]').repeat(1) }

  rule(:attribute_flag) do
    space >>
      (str('--') >> match('[ 0-9a-zA-Z:-]').repeat).as(:flags)
  end

  rule(:attribute) do
    space? >>
      match('[0-9a-zA-Z:-]').repeat.as(:attribute) >>
      attribute_flag.maybe >>
      new_line
  end

  rule(:body) do
    lparen >>
      new_line >>
      attribute.repeat.as(:attributes) >>
      new_line? >>
      rparen
  end

  rule(:class) do
    class_keyword >>
      space >>
      class_name.as(:class) >>
      space? >>
      body
  end

  root :class
end

begin
  ap MiniP.new.parse(classes_collection.first)
rescue Parslet::ParseFailed => e
  puts e.parse_failure_cause.ascii_tree
end
