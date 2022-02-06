# frozen_string_literal: true

def install_bootstrap
  install_gems

  configure_assets
  configure_bootstrap_pins
  configure_bootstrap_js
  configure_scss
  add_stimulus_controller
  configure_stimulus_controller
end

def configure_assets
  append_to_file(
    'app/assets/config/manifest.js',
    read_insert_file('app/assets/config/manifest')
  )
end

def configure_bootstrap_pins
  append_to_file(
    'config/importmap.rb',
    read_insert_file('config/importmap')
  )
end

def configure_bootstrap_js
  append_to_file(
    'app/javascript/application.js',
    read_insert_file('app/javascript/application')
  )
end

def configure_scss
  remove_file 'app/stylesheets/application.css'

  template 'app/stylesheets/application.scss.tt'
end

def add_stimulus_controller
  template 'app/javascript/controller/bs_controller.js.tt'
end

def configure_stimulus_controller
  template_into_file(
    'app/views/layout/application.html.slim',
    after: 'body'
  )

  template_into_file(
    'app/views/layout/admin.html.slim',
    after: 'body'
  )
end