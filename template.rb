# frozen_string_literal: true

require_relative 'support'
require_relative 'process_decorator'

def source_paths
  [__dir__]
end

self.class.prepend ProcessDecorator

install_generators

configure_database

remove_lines 'Gemfile', 'tzinfo-data'

directory 'inserts', 'tmp/inserts'

after_bundle do
  install_rails_linters
  install_eslint
  install_tests
  configure_model_tools

  configure_layout

  install_devise
  install_bootstrap
  install_pagy

  configure_system_test

  install_view_component

  install_bs_view_component

  configure_application

  install_overcommit

  remove_dir 'tmp/inserts'

  run 'rails db:seed'

  git add: '.'
  git commit: "-a -m 'Initial commit'"
end
