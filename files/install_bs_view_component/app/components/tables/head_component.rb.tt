module Tables
  class HeadComponent < ViewComponent::Base
    def initialize(thead:)
      super

      @thead = thead
    end

    def render?
      thead.present?
    end

    private

    attr_reader :thead
  end
end
