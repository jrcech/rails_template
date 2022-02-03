# frozen_string_literal: true

def configure_application
  install_gems

  configure_generators
  # configure_i18n
  configure_seedbank
  configure_slim
  configure_git
  install_view_components
  install_model_tools
  install_pagy
  install_simple_form
  install_gretel

  process_directory
end

def configure_generators
  remove_lines 'config/application.rb', 'config.generators.system_tests'

  template_into_file 'config/application.rb', before: second_last_end
end

# def configure_i18n
#   template_into_file(
#     'app/controllers/application_controller.rb',
#     after: "class ApplicationController < ActionController::Base\n"
#   )
# end

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

def install_view_components
  insert_into_file(
    'config/application.rb',
    read_insert_file('config/application_view_components'),
    after: "Bundler.require(*Rails.groups)\n"
  )
end

def install_pagy
  insert_into_file(
    'app/controllers/application_controller.rb',
    read_insert_file('app/controllers/application_controller_pagy'),
    after: "class ApplicationController < ActionController::Base\n"
  )

  template_into_file(
    'app/helpers/application_helper.rb',
    after: "module ApplicationHelper\n"
  )

  run 'rails webpacker:install:erb'

  remove_file 'app/javascript/packs/hello_erb.js.erb'

  template_into_file(
    'app/javascript/packs/application.js',
    after: "import \"channels\"\n"
  )
end

def install_simple_form
  run 'rails generate simple_form:install --bootstrap'
end

def install_gretel
  run 'rails generate gretel:install'
end
