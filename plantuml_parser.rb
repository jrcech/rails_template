# frozen_string_literal: true

require 'parslet'
require 'amazing_print'

file = File.read(File.join('./docs', 'test.md'))

classes_collection = file.scan(/class\s[a-zA-Z\s<>_]*\s{[^}]*}/)

ap classes_collection

puts "\n"

puts classes_collection.first

puts "\n"

class ClassDiagramParser < Parslet::Parser
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
      match('[0-9a-zA-Z:-_]').repeat.as(:attribute) >>
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

model = []

classes_collection.each do |class_definition|
  model << ClassDiagramParser.new.parse(class_definition)
rescue Parslet::ParseFailed => e
  puts e.parse_failure_cause.ascii_tree
end

ap model
