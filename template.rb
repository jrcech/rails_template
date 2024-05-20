require_relative 'support'
require_relative 'process_decorator'

def source_paths
  [__dir__]
end

self.class.prepend ProcessDecorator

directory 'inserts', 'tmp/inserts'

configure_generators
configure_database

remove_lines 'Gemfile', 'tzinfo-data'

after_bundle do
  install_development_tools
  install_tests
  configure_model_tools

  configure_layout

  configure_authentication
  install_pagy

  configure_integrations_test

  install_bs_view_component

  configure_application

  remove_dir 'tmp/inserts'

  run 'bundle install'
  run 'rails stimulus:manifest:update'
  run 'rails pagy:link_module'
  run 'bun run build'

  run 'rails db:migrate'
  run 'rails db:seed'
end
