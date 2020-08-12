# frozen_string_literal: true

module CommentedConfigFiles
  def self.list
    %w[
      config/environments/development.rb
      config/environments/production.rb
      config/environments/test.rb
      config/initializers/application_controller_renderer.rb
      config/initializers/backtrace_silencers.rb
      config/initializers/content_security_policy.rb
      config/initializers/cookies_serializer.rb
      config/initializers/devise.rb
      config/initializers/filter_parameter_logging.rb
      config/initializers/inflections.rb
      config/initializers/mime_types.rb
      config/initializers/rolify.rb
      config/initializers/wrap_parameters.rb
      config/locales/en.yml
      config/boot.rb
      config/database.yml
      config/puma.rb
      config/routes.rb
      config/storage.yml
      config/webpacker.yml
      lib/tasks/auto_annotate_models.rake
    ]
  end
end
