def configure_system_test
  template_into_file(
    'config/routes.rb',
    after: "namespace :admin do\n"
  )

  process_directory
end