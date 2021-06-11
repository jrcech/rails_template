# frozen_string_literal: true

def install_frontend_linters
  @process = __method__.to_s

  run "yarn add --dev #{read_support_file('yarn_linters').tr("\n", ' ')}"
  run "yarn add #{read_support_file('yarn_postcss').tr("\n", ' ')}"

  directory 'files/install_frontend_linters', './'
end
