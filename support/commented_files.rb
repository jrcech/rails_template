# frozen_string_literal: true

module CommentedFiles
  def self.list
    %w[
      app/jobs/application_job.rb
      app/models/user.rb
      config/application.rb
      config/environment.rb
      config/routes.rb
      spec/rails_helper.rb
      spec/spec_helper.rb
      .gitignore
      config.ru
      Gemfile
      Rakefile
    ]
  end
end
