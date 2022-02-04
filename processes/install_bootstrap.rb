# frozen_string_literal: true

def install_bootstrap
  install_gems

  configure_assets
  configure_bootstrap_pins
  configure_bootstrap_js
  configure_scss
end

def configure_assets
  append_to_file(
    'config/initializers/assets.rb',
    read_insert_file('config/initializers/assets')
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
end