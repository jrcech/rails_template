# frozen_string_literal: true

def install_overcommit
  append_to_file 'Gemfile', File.read('./tmp/inserts/Gemfile_overcommit')
  run 'bundle install'
  directory 'files/overcommit', './'
  run 'overcommit --install'
  run 'overcommit -r'
end
