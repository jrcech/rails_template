# frozen_string_literal: true

module UrlSupport
  attr_reader :action, :id

  def url_for(options = {})
    @action = options[:action]
    @id = options[:id]

    send_url
  end

  def send_url
    return send construct_url, id: id if show? || edit? || update? || destroy?

    send construct_url
  end

  private

  def construct_url
    url = +''
    url << "#{action}_" if action_prefix?
    url << "#{namespace}_" if namespace.present?
    url << "#{format_resource}_url"

    url
  end

  url_actions = %i[
    index
    show
    new
    edit
    create
    update
    destroy
  ]

  url_actions.each do |url_action|
    define_method("#{url_action}?") do
      return true if action == url_action

      false
    end
  end

  def action_prefix?
    return true if new? || edit?

    false
  end

  def format_resource
    return resource_plural_symbol if index? || create?

    resource_singular_symbol
  end
end

RSpec.configure do |config|
  config.include UrlSupport
end
