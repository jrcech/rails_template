# frozen_string_literal: true

def remove_file(file)
  run("rm -f #{file}")
end

def remove_dir(dir)
  run("rm -rf #{dir}")
end

def remove_file_comments(file)
  gsub_file(file, /^\s*#.*$\n/, '')
end

def remove_comments(files)
  files.each do |file|
    remove_file_comments file
  end
end

def remove_whitespaces(file)
  gsub_file(file, /\S\K([ ]{2,})/, ' ')
end

def rubocop_file(file)
  run("rubocop -a #{file}")
end

def eslint
  run('yarn run eslint --fix .')
end

remove_dir 'app/assets'
remove_file 'db/seeds.rb'

commented_files = %w[
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
config/initializers/wrap_parameters.rb
config/locales/en.yml
config/application.rb
config/boot.rb
config/database.yml
config/environment.rb
config/puma.rb
config/routes.rb
config/storage.yml
.gitignore
config.ru
Gemfile
Rakefile
]

remove_comments(commented_files)

remove_whitespaces 'config/environments/production.rb'
remove_whitespaces 'config/environments/test.rb'
remove_whitespaces 'config/puma.rb'

# rubocop_file 'app/jobs/application_job.rb'
# rubocop_file 'config/environments/development.rb'
# rubocop_file 'config/environments/production.rb'
# rubocop_file 'config/environments/test.rb'
# rubocop_file 'config/initializers/application_controller_renderer.rb'
# rubocop_file 'config/initializers/backtrace_silencers.rb'
# rubocop_file 'config/initializers/cookies_serializer.rb'
# rubocop_file 'config/initializers/content_security_policy.rb'
# rubocop_file 'config/initializers/filter_parameter_logging.rb'
# rubocop_file 'config/initializers/inflections.rb'
# rubocop_file 'config/initializers/mime_types.rb'
# rubocop_file 'config/initializers/wrap_parameters.rb'
# rubocop_file 'Gemfile'
# rubocop_file 'config/application.rb'
# rubocop_file 'config/rubocop.rb'
# rubocop_file 'config/rubocop.rb'
# rubocop_file 'config/puma.rb'
# rubocop_file 'config/routes.rb'
# rubocop_file 'Rakefile'
# rubocop_file 'config.ru'

# Frozen string literals
# rubocop_file 'app/channels/application_cable/channel.rb'
# rubocop_file 'app/channels/application_cable/connection.rb'
# rubocop_file 'app/controllers/application_controller.rb'
# rubocop_file 'app/helpers/application_helper.rb'
# rubocop_file 'app/mailers/application_mailer.rb'
# rubocop_file 'app/models/application_model.rb'
