# frozen_string_literal: true

module ResourceSupport
  attr_reader :resource, :namespace

  def resource_for(resource, namespace = nil)
    @resource = resource
    @namespace = namespace
  end

  def model
    resource.to_s.classify.safe_constantize
  end

  def resource_singular
    resource.to_s.singularize
  end

  def resource_singular_symbol
    resource_singular.to_sym
  end

  def resource_plural
    resource.to_s
  end

  def resource_plural_symbol
    resource
  end
end

RSpec.configure do |config|
  config.include ResourceSupport
end
