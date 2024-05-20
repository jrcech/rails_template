def install_pagy
  template_into_file 'Gemfile', before: 'group :development, :test do'

  add_pagy_backend
  add_pagy_frontend

  process_directory
end

def add_pagy_frontend
  template_into_file(
    'app/helpers/application_helper.rb',
    after: "module ApplicationHelper\n"
  )
end

def add_pagy_backend
  template_into_file(
    'app/controllers/application_controller.rb',
    after: "class ApplicationController < ActionController::Base\n"
  )
end
