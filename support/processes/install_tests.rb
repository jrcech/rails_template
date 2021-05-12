# frozen_string_literal: true

def install_tests
  append_to_file 'Gemfile', File.read('./tmp/inserts/install_tests/Gemfile')
  run 'bundle install'

  # RSpec
  run 'DISABLE_SPRING=1 rails generate rspec:install'

  run 'rubocop spec/rails_helper.rb --auto-correct-all'
  remove_comments_from_file 'spec/rails_helper.rb'
  remove_comments_from_file 'spec/rails_helper.rb'
  remove_comments_from_file 'spec/spec_helper.rb'

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

  run 'rubocop spec --auto-correct-all'
  run 'rubocop config/environments/development.rb --auto-correct-all'
end
