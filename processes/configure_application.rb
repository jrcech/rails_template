# frozen_string_literal: true

def configure_application
  @process = __method__.to_s

  install_gems

  configure_generators
  configure_mailer
  configure_i18n
  configure_seedbank
  configure_slim
  configure_git
  install_model_tools

  process_directory
end

def configure_generators
  remove_lines 'config/application.rb', 'config.generators.system_tests'

  template_into_file 'config/application.rb', before: second_last_end
end

def configure_mailer
  template_into_file(
    'config/environments/development.rb',
    after: "config.action_mailer.perform_caching = false\n"
  )

  template_into_file(
    'config/environments/test.rb',
    after: "config.action_mailer.perform_caching = false\n"
  )
end

def configure_i18n
  template_into_file(
    'app/controllers/application_controller.rb',
    after: "class ApplicationController < ActionController::Base\n"
  )
end

def install_model_tools
  run 'rails generate annotate:install'
  run 'rails generate erd:install'
end

def configure_seedbank
  remove_file 'db/seeds.rb'
end

def configure_slim
  remove_file 'app/views/layouts/application.html.erb'
end

def configure_git
  append_to_file '.gitignore', read_insert_file('.gitignore')
end
