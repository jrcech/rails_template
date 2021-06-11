# frozen_string_literal: true

def install_rails_linters
  append_to_file 'Gemfile', File.read('./tmp/inserts/install_rails_linters/Gemfile')
  run 'bundle install'
  directory 'files/install_rails_linters', './'
end
