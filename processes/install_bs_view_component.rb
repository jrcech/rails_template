def install_bs_view_component
  template_into_file 'Gemfile', before: 'group :development, :test do'

  run 'bun add @fortawesome/fontawesome-free'

  process_directory
end
