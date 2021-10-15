# frozen_string_literal: true

require 'parslet'
require 'amazing_print'

class String
  def underscore
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
end

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

class AssociationsParser < Parslet::Parser
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

file = File.read(File.join('./docs', 'test.md'))

classes = file.scan(/class\s[a-zA-Z\s<>_]*\s{[^}]*}/)
associations = file.scan(/.*(?:<--|-->).*/)

puts "\n"

puts "\n"

model = {
  classes: [],
  associations: []
}

classes.each do |class_definition|
  model[:classes] << ClassDiagramParser.new.parse(class_definition)
rescue Parslet::ParseFailed => e
  puts e.parse_failure_cause.ascii_tree
end

associations.each do |association|
  model[:associations] << AssociationsParser.new.parse(association)
rescue Parslet::ParseFailed => e
  puts e.parse_failure_cause.ascii_tree
end

ap model
ap associations

associations_hash = {}

model[:associations].each do |association|
  left_class = association[:left_class].to_s.underscore.to_sym
  right_class = association[:right_class].to_s.underscore.to_sym

  if associations_hash[left_class].nil?
    associations_hash[left_class] = right_class
  elsif associations_hash[left_class].is_a? Array
    associations_hash[left_class] << right_class
  else
    associations_hash[left_class] = [associations_hash[left_class]]
    associations_hash[left_class] << right_class
  end
end

ap associations_hash

def top_level_classes(associations_hash)
  top_level = []

  associations_hash.each do |key, _|
    next if associations_hash.values.flatten.include? key

    top_level << key
  end

  top_level
end

ap top_level_classes(associations_hash)

def deep_hash(hash, value_symbol = nil)
  new_hash = {}

  hash.each do |key, value|
    if value_symbol.nil?
      if hash[key].is_a? Array
        arr = []

        hash[key].each do |array_value|
          if hash.key? array_value
            arr << { array_value => deep_hash(hash, hash[array_value]) }
          else
            arr << array_value
          end
        end

        new_hash[key] = arr
      else
        new_hash[key] = deep_hash(hash, value)
      end

    elsif hash.key?(value_symbol)
      if hash[value_symbol].is_a? Array
        arr = []

        hash[value_symbol].each do |array_value|
          if hash.key? array_value
            arr << { array_value => deep_hash(hash, hash[array_value]) }
          else
            arr << array_value
          end
        end

        new_hash[value_symbol] = arr
      else
        new_hash[value_symbol] = deep_hash(hash, hash[value_symbol])
      end
    else
      new_hash = value_symbol
    end
  end

  new_hash
end

def hasher(associations_hash)
  full_hash = []

  top_level_classes(associations_hash).each do |top_level_class|
    full_hash << deep_hash(associations_hash, top_level_class)
  end

  full_hash
end

# ap Hash[*deep_hash(associations_hash).first]
# ap deep_hash(associations_hash)
ap hasher(associations_hash)
