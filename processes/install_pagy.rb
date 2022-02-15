def install_pagy
  install_gems

  template 'config/initializers/pagy.rb.tt'
  template 'app/assets/stylesheets/pagy.scss.tt'

  add_pagy_js
  add_pagy_backend
  add_pagy_frontend
  install_pagy_controller
end

def add_pagy_js
  template_into_file(
    'package.json',
    before: 'esbuild app/javascript/*.*'
  )
end

def install_pagy_controller
  template 'app/javascript/controllers/pagy_controller.js.tt'

  run 'stimulus:manifest:update'
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