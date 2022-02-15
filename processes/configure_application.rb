# frozen_string_literal: true

def configure_application
  install_gems

  configure_git
  install_gretel

  process_directory
end

def configure_git
  append_to_file '.gitignore', read_insert_file('.gitignore')
end

def install_gretel
  run 'rails generate gretel:install'
end
