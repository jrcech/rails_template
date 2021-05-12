# frozen_string_literal: true

def install_frontend_linters
  run "yarn add --dev #{File.read('./tmp/inserts/install_frontend_linters/yarn_linters').tr("\n", ' ')}"
  directory 'files/install_frontend_linters', './'
  prepend_to_file 'postcss.config.js', "/* eslint-disable global-require */\n\n"
  gsub_file 'babel.config.js', 'function(api)', '(api) =>'
  run "yarn add #{File.read('./tmp/inserts/install_frontend_linters/yarn_postcss').tr("\n", ' ')}"
  run 'yarn run eslint . --fix'
end
