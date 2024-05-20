def configure_integrations_test
  template_into_file(
    'config/routes.rb',
    before: third_last_end
  )

  template_into_file(
    'app/assets/stylesheets/application.bootstrap.scss',
    after: "@import 'bootstrap-icons/font/bootstrap-icons';\n"
  )

  process_directory
end
