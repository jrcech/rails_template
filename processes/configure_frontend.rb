# frozen_string_literal: true

def configure_frontend
  install_gems

  install_hotwire
  # restyle_js_files
  install_frontend
  configure_js
  configure_provide_plugin

  process_directory
end

def install_hotwire
  run 'rails hotwire:install'

  remove_file 'app/javascript/controllers/hello_controller.js'
end

def restyle_js_files
  prepend_to_file 'postcss.config.js', "/* eslint-disable global-require */\n\n"
  gsub_file 'babel.config.js', 'function(api)', '(api) =>'
end

def configure_js
  template_to_file(
    'app/javascript/packs/application.js',
    after: "import \"channels\"\n"
  )
end

def configure_provide_plugin
  template_into_file(
    'config/webpack/environment.js',
    after: "const { environment } = require('@rails/webpacker')\n"
  )
end

def install_frontend
  run "yarn add #{read_support_file('yarn_frontend').tr("\n", ' ')}"

  template_into_file(
    'app/views/layouts/admin.html.slim',
    after: 'body'
  )
end
