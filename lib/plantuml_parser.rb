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
    model_hash = parse_model
    associations_hash = transform_associations(model_hash)
    top_level_classes_array = top_level_classes(associations_hash)

    transform_model_hash(associations_hash, top_level_classes_array)
  end

  private

  attr_reader :file

  def parse_model
    classes = file.scan(/class\s[a-zA-Z\s<>_]*\s{[^}]*}/)
    associations = file.scan(/.*(?:<--|-->).*/)

    model = {
      classes: [],
      associations: []
    }

    classes.each do |class_definition|
      model[:classes] << PlantumlParser::Class.new.parse(class_definition)
    rescue Parslet::ParseFailed => e
      puts e.parse_failure_cause.ascii_tree
    end

    associations.each do |association|
      model[:associations] << PlantumlParser::Association.new.parse(association)
    rescue Parslet::ParseFailed => e
      puts e.parse_failure_cause.ascii_tree
    end

    model
  end

  def transform_associations(model)
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

    associations_hash
  end

  def top_level_classes(associations_hash)
    top_level = []

    associations_hash.each do |key, _|
      next if associations_hash.values.flatten.include? key

      top_level << key
    end

    top_level
  end

  def transform_model_hash(associations_hash, top_level_classes)
    full_hash = []

    top_level_classes.each do |top_level_class|
      full_hash << deep_hash(associations_hash, top_level_class)
    end

    full_hash
  end

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
end

file = File.read(File.join('./docs', 'test.md'))

ap PlantumlParser.new(file).parse

# ap Hash[*deep_hash(associations_hash).first]
# ap deep_hash(associations_hash)
# ap hasher(associations_hash)
