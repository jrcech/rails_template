def install_development_tools
  template_into_file 'Gemfile', after: "group :development do\n"

  process_directory
end
