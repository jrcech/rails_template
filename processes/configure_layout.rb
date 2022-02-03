def configure_layout
  install_gems

  template_into_file(
    'config/routes.rb',
    after: 'Rails.application.routes.draw do'
  )

  template_into_file(
    'app/controllers/application_controller.rb',
    after: 'class ApplicationController < ActionController::Base'
  )

  remove_file 'app/views/layouts/application.html.erb'

  process_directory
end
