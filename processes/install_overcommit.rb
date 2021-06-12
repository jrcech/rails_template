# frozen_string_literal: true

def install_overcommit
  append_to_file 'Gemfile', File.read('./tmp/inserts/install_overcommit/Gemfile')
  run 'bundle install'

  directory 'files/install_overcommit', './'

  run 'overcommit --install'

  #   git :init
  #   git add: '.'
  #   git commit: "-a -m 'Initial commit'"
end
