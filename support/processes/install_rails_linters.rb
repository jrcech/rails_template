# frozen_string_literal: true

def install_rails_linters
  append_to_file 'Gemfile', File.read('./tmp/inserts/Gemfile_linters')
  run 'bundle install'
  directory 'files/rails_linters', './'
  run 'rubocop --auto-correct-all'
end
