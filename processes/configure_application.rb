# frozen_string_literal: true

def configure_application
  install_gems

  configure_git
  install_pagy
  install_gretel

  process_directory
end

def configure_git
  append_to_file '.gitignore', read_insert_file('.gitignore')
end

def install_pagy
  insert_into_file(
    'app/controllers/application_controller.rb',
    read_insert_file('app/controllers/application_controller_pagy'),
    after: "class ApplicationController < ActionController::Base\n"
  )

  template_into_file(
    'app/helpers/application_helper.rb',
    after: "module ApplicationHelper\n"
  )

  run 'rails webpacker:install:erb'

  remove_file 'app/javascript/packs/hello_erb.js.erb'

  template_into_file(
    'app/javascript/packs/application.js',
    after: "import \"channels\"\n"
  )
end

def install_gretel
  run 'rails generate gretel:install'
end
