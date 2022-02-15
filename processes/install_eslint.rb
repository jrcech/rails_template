# frozen_string_literal: true

def install_eslint
  run "yarn add --dev #{read_support_file('yarn_eslint').tr("\n", ' ')}"

  directory 'files/install_eslint', './'
end
