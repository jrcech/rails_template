# frozen_string_literal: true

def install_frontend_linters
  run "yarn add --dev #{read_template_file('yarn_linters').tr("\n", ' ')}"
  run "yarn add #{read_template_file('yarn_postcss').tr("\n", ' ')}"

  directory 'files/install_frontend_linters', './'
end