# frozen_string_literal: true

module MultipleWhitespaceFiles
  def self.list
    %w[
      config/environments/production.rb
      config/environments/test.rb
      config/puma.rb
    ]
  end
end
