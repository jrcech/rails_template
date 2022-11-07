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
    @parsed_file = parse_file
    @associations = base_associations
    @attributes = transform_attributes

    ap @parsed_file
    ap @associations
    ap @attributes
    ap associations_with_attributes
    ap class_generator_commands(model_hash)
  end

  private

  attr_reader :file, :associations, :parsed_file, :attributes

  def class_generator_commands(model_hash)
    array = []

    model_hash[:classes].each do |class_definition|
      attributes = []

      class_definition[:attributes].each do |attribute|
        attributes << attribute[:attribute]
      end

      array << "#{class_definition[:class]} #{attributes.join(' ')}"
    end

    array
  end

  def parse_file
    classes = file.scan(/class\s[a-zA-Z\s<>_]*\s{[^}]*}/)
    associations = file.scan(/.*(?:<--|-->|--).*/)

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

  def base_associations
    hash = {}

    parsed_file[:associations].each do |association|
      left_class = class_name_to_sym(association[:left_class])
      left_cardinality = association[:left_cardinality].to_s.gsub('"', '')

      right_class = class_name_to_sym(association[:right_class])
      right_cardinality = association[:right_cardinality].to_s.gsub('"', '')

      if hash[left_class].nil?
        hash[left_class] = { belongs_to: [], has_many: [] }
      end

      hash[left_class][:belongs_to] << right_class if right_cardinality == '1'
      hash[left_class][:has_many] << right_class if right_cardinality == '*'

      if hash[right_class].nil?
        hash[right_class] = { belongs_to: [], has_many: [] }
      end

      hash[right_class][:belongs_to] << left_class if left_cardinality == '1'
      hash[right_class][:has_many] << left_class if left_cardinality == '*'
    end

    hash
  end

  def transform_attributes
    hash = {}

    parsed_file[:classes].each do |class_definition|
      class_name = class_definition[:class].to_s.underscore.to_sym

      hash[class_name] = {
        attributes: iterate_attributes(class_definition[:attributes])
      }
    end

    hash
  end

  def iterate_attributes(attributes)
    array = []

    attributes.each do |attribute|
      array << {
        name: attribute[:name].to_s,
        flags: transform_flags(attribute[:flags])
      }
    end

    array
  end

  def transform_flags(flags)
    array = []

    flags.each do |flag|
      array << flag[:flag].to_s.tr(':', '').to_sym
    end

    array
  end

  def associations_with_attributes
    associations.merge(attributes) { |_, new, old| new.merge(old) }
  end

  def belongs_to_class(class_symbol, cardinality)
    class_symbol if cardinality == '1'
  end

  def class_name_to_sym(name)
    name.to_s.underscore.to_sym
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
end

file = File.read(File.join('./docs', 'blogger.md'))

PlantumlParser.new(file).parse
