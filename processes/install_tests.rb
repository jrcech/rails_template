# frozen_string_literal: true

def install_tests
  install_gems

  configure_rspec
  configure_simplecov
  configure_bullet

  process_directory
end

def configure_rspec
  run 'rails generate rspec:install'
  uncomment_lines 'spec/rails_helper.rb', /'spec', 'support'/
  append_to_file '.rspec', read_insert_file('.rspec')
end

def configure_capybara
  template_into_file 'spec/rails_helper.rb', after: "require 'rspec/rails'\n"
end

def configure_simplecov
  insert_into_file(
    'spec/rails_helper.rb',
    read_insert_file('spec/rails_helper_simplecov'),
    before: "require 'spec_helper'"
  )
end

def configure_bullet
  template_into_file(
    'config/environments/development.rb',
    after: "ActiveSupport::EventedFileUpdateChecker\n"
  )
end
