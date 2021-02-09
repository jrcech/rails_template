# frozen_string_literal: true

module CommentedFiles
  def self.list
    %w[
      app/javascript/channels/consumer.js
      app/javascript/channels/index.js
      app/javascript/controllers/index.js
      app/javascript/packs/application.js
      app/jobs/application_job.rb
      config/environments/development.rb
      config/environments/production.rb
      config/environments/test.rb
      config/initializers/application_controller_renderer.rb
      config/initializers/backtrace_silencers.rb
      config/initializers/content_security_policy.rb
      config/initializers/cookies_serializer.rb
      config/initializers/filter_parameter_logging.rb
      config/initializers/inflections.rb
      config/initializers/mime_types.rb
      config/initializers/permissions_policy.rb
      config/initializers/wrap_parameters.rb
      config/locales/en.yml
      config/application.rb
      config/boot.rb
      config/database.yml
      config/environment.rb
      config/puma.rb
      config/routes.rb
      config/storage.yml
      config/webpacker.yml
      db/seeds.rb
      .gitignore
      .gitattributes
      config.ru
      Gemfile
      Rakefile
    ]
  end
end
