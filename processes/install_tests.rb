# frozen_string_literal: true

def install_tests
  append_to_file 'Gemfile', File.read('./tmp/inserts/install_tests/Gemfile')
  run 'bundle install'

  run 'rails generate rspec:install'

  append_to_file '.rspec', "--format documentation\n--color\n"

  inject_into_file(
    'spec/rails_helper.rb',
    File.read('./tmp/inserts/install_tests/spec/rails_helper'),
    after: "require 'rspec/rails'\n"
  )

  # Simplecov
  inject_into_file(
    'spec/rails_helper.rb',
    "require 'simplecov'\nSimpleCov.start\n\n",
    before: "require 'spec_helper'"
  )

  # Bullet
  inject_into_file(
    'config/environments/development.rb',
    File.read('./tmp/inserts/install_tests/config/environments/development'),
    after: "ActiveSupport::EventedFileUpdateChecker\n"
  )

  # Configure RSpec tool
  directory 'files/install_tests/spec/support', './spec/support'
end
