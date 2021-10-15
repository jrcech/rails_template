# frozen_string_literal: true

require 'parslet'
require 'amazing_print'

require_relative 'plantuml_parser/class'
require_relative 'plantuml_parser/association'
require_relative 'plantuml_parser/string'

class PlantumlParser
  def initialize(file)
    @file = file
  end

  def parse
    model_hash = parse_file
    base_associations_hash = base_associations(model_hash)
    top_level_classes_array = top_level_classes(base_associations_hash)

    nested_associations_array = nested_associations(
      base_associations_hash,
      top_level_classes_array
    )

    ap nested_associations_array
  end

  private

  attr_reader :file

  def parse_file
    classes = file.scan(/class\s[a-zA-Z\s<>_]*\s{[^}]*}/)
    associations = file.scan(/.*(?:<--|-->).*/)

    {
      classes: parse_classes(classes),
      associations: parse_associations(associations)
    }
  end

  def parse_classes(classes)
    array = []

    classes.each do |class_definition|
      array << PlantumlParser::Class.new.parse(class_definition)
    rescue Parslet::ParseFailed => e
      puts e.parse_failure_cause.ascii_tree
    end

    array
  end

  def parse_associations(associations)
    array = []

    associations.each do |association|
      array << PlantumlParser::Association.new.parse(association)
    rescue Parslet::ParseFailed => e
      puts e.parse_failure_cause.ascii_tree
    end

    array
  end

  def base_associations(model)
    hash = {}

    model[:associations].each do |association|
      left_class = class_name_to_sym(association[:left_class])
      right_class = class_name_to_sym(association[:right_class])

      construct_base_associations(hash, left_class, right_class)
    end

    hash
  end

  def construct_base_associations(hash, left_class, right_class)
    if hash[left_class].nil?
      hash[left_class] = right_class
    elsif hash[left_class].is_a? Array
      hash[left_class] << right_class
    else
      hash[left_class] = [hash[left_class]]
      hash[left_class] << right_class
    end
  end

  def class_name_to_sym(name)
    name.to_s.underscore.to_sym
  end

  def nested_associations(associations_hash, top_level_classes)
    array = []

    top_level_classes.each do |top_level_class|
      array << transform_associations(
        associations_hash,
        top_level_class
      )
    end

    array
  end

  def top_level_classes(associations_hash)
    array = []

    associations_hash.each do |key, _|
      next if associations_hash.values.flatten.include? key

      array << key
    end

    array
  end

  def transform_associations(hash, value_symbol = nil)
    new_hash = {}

    hash.each do |key, value|
      new_hash = new_hash_pair(hash, value_symbol, key, value)
    end

    new_hash
  end

  def new_hash_pair(hash, value_symbol, key, value)
    new_hash = {}

    if value_symbol.nil?
      new_hash[key] = new_hash_item(hash, value)
    elsif hash.key?(value_symbol)
      new_hash[value_symbol] = new_hash_item(hash, hash[value_symbol])
    else
      new_hash = value_symbol
    end

    new_hash
  end

  def new_hash_item(hash, value)
    return iterate_association_array(hash, value) if value.is_a? Array

    transform_associations(hash, value)
  end

  def iterate_association_array(hash, array_values)
    array = []

    array_values.each do |array_value|
      array << transform_array_value(hash, array_value)
    end

    array
  end

  def transform_array_value(hash, array_value)
    if hash.key? array_value
      { array_value => transform_associations(hash, hash[array_value]) }
    else
      array_value
    end
  end
end

file = File.read(File.join('./docs', 'test.md'))

ap PlantumlParser.new(file).parse

# ap Hash[*deep_hash(associations_hash).first]
# ap deep_hash(associations_hash)
# ap hasher(associations_hash)
