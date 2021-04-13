# frozen_string_literal: true

def install_frontend_lintes
  run "yarn add --dev #{File.read('./tmp/inserts/yarn_linters').tr("\n", ' ')}"
  directory 'files/frontend_linters', './'
  prepend_to_file 'postcss.config.js', "/* eslint-disable global-require */\n\n"
  gsub_file 'babel.config.js', 'function(api)', '(api) =>'
  run "yarn add #{File.read('./tmp/inserts/yarn_postcss').tr("\n", ' ')}"
  run 'yarn run eslint . --fix'
end
