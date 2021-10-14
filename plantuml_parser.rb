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


  rule(:class_definition) { class_keyword >> space >> class_name.as(:class) >> space? >> class_body }

  rule(:attribute_flag) { str('--') >> match('[ 0-9a-zA-Z:-]').repeat }
  rule(:class_attribute) { match('[0-9a-zA-Z:-]').repeat.as(:attribute) >> space >> attribute_flag.as(:flag) >> new_line }


  rule(:class_attributes) { space? >> class_attribute }

  rule(:class_body) { lparen >> new_line >> class_attributes.repeat >> new_line? >> rparen }


  rule(:expression) { class_definition }

  root :expression
end

begin
  ap MiniP.new.parse(classes_collection.first)
rescue Parslet::ParseFailed => e
  puts e.parse_failure_cause.ascii_tree
end
