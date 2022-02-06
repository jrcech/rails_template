def install_pagy
  install_gems

  template 'config/initializers/pagy.rb.tt'
  template 'app/assets/stylesheets/pagy.scss.tt'

  template_into_file(
    'app/controllers/application_controller.rb',
    after: "class ApplicationController < ActionController::Base\n"
  )

  template_into_file(
    'app/helpers/application_helper.rb',
    after: "module ApplicationHelper\n"
  )

  append_to_file(
    'app/javascript/application.js',
    read_insert_file('app/javascript/application')
  )

  append_to_file(
    'app/assets/config/manifest.js',
    read_insert_file('app/assets/config/manifest')
  )

  append_to_file(
    'config/importmap.rb',
    read_insert_file('config/importmap')
  )
end
