# frozen_string_literal: true

def install_rspec
  generate 'rspec:install'
  append_to_file '.rspec', "--format documentation\n--color\n"
  run 'rubocop spec/spec_helper.rb --auto-correct-all'
  prepend_to_file 'spec/rails_helper.rb',
                  "require 'simplecov'\nSimpleCov.start\n\n"

  inject_into_file 'spec/rails_helper.rb',
                   File.read('./insert_files/spec/rails_helper.rb'),
                   after: "require 'rspec/rails'\n"
end
