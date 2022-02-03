# frozen_string_literal: true

def configure_model_tools
  install_gems

  install_seedbank
  install_erd
  install_annotate

  process_directory
end

def install_seedbank
  remove_file 'db/seeds.rb'
end

def install_erd
  run 'rails generate erd:install'
end

def install_annotate
  run 'rails generate annotate:install'
end
