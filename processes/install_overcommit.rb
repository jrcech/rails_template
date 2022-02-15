# frozen_string_literal: true

def install_overcommit
  install_gems

  directory 'files/install_overcommit', './'

  run 'overcommit --install'

  #   git :init
  #   git add: '.'
  #   git commit: "-a -m 'Initial commit'"
end
