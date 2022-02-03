def configure_layout
  install_gems

  remove_default_layout
  configure_routes
  configure_i18n
  configure_slim_generation

  process_directory
end

def remove_default_layout
  remove_file 'app/views/layouts/application.html.erb'
end

def configure_routes
  template_into_file(
    'config/routes.rb',
    after: 'Rails.application.routes.draw do'
  )
end

def configure_i18n
  template_into_file(
    'app/controllers/application_controller.rb',
    after: 'class ApplicationController < ActionController::Base'
  )
end

def configure_slim_generation
  template_into_file(
    'config/application.rb',
    after: "config.generators do |generator|\n"
  )
end
