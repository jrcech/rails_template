def configure_layout
  template_into_file 'Gemfile', before: 'group :development, :test do'

  remove_default_layout
  configure_routes
  configure_i18n
  configure_slim_generator

  process_directory
end

def remove_default_layout
  remove_lines 'config/routes.rb', 'get "up"'
  remove_file 'app/views/layouts/application.html.erb'
  remove_file 'app/views/layouts/mailer.html.erb'
  remove_file 'app/views/layouts/mailer.text.erb'
  remove_file 'config/locales/en.yml'
end

def configure_routes
  template_into_file(
    'config/routes.rb',
    before: last_end
  )
end

def configure_i18n
  template_into_file(
    'app/controllers/application_controller.rb',
    after: "class ApplicationController < ActionController::Base\n"
  )
end

def configure_slim_generator
  template_into_file(
    'config/application.rb',
    after: "config.generators do |generator|\n"
  )
end
