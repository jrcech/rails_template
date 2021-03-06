# frozen_string_literal: true

require_relative 'support/commented_config_files'
require_relative 'support/commented_files'
require_relative 'support/commented_js_files'
require_relative 'support/multiple_whitespace_files'
require_relative 'support/yarn_dev_packages'
require_relative 'support/yarn_packages'

def remove_file_comments(file, options = {})
  regex = if options[:delete_blank_lines]
    /^\s*#.*$\n/
          else
    /^[ ]*#.*$\n/
          end

  gsub_file(file, regex, '')
end

def remove_js_file_comments(file, options = {})
  regex = if options[:delete_blank_lines]
    /^\s*\/\/.*$\n/
          else
    /^[ ]*\/\/.*$\n/
          end

  gsub_file(file, regex, '')
end

def remove_file_inline_comments(file, options = {})
  gsub_file(file, /#[\w\s]*\./, '')
end

def remove_file_whitespaces(file, options = {})
  gsub_file(file, /\S\K([ ]{2,})/, ' ')
end

def change_files(files, change_file_method, options = {})
  files.each do |file|
    send(change_file_method, file, options)
  end
end

def rubocop_file(file)
  run("rubocop -a #{file}")
end

def rubocop_correct_all
  run('rubocop -a')
end

def eslint
  run('yarn run eslint --fix .')
end

def append_to_file_line(file, search_line, append_string)
  replace_string = "#{search_line}\n#{append_string}"
  gsub_file(file, search_line, replace_string)
end

def append_to_file_names(dir, append_string)
  rb_files = File.join(dir, '**', '*.rb')
  slim_files = File.join(dir, '**', '*.slim')

  Dir.glob([rb_files, slim_files]).each do |file|
    replace_string = "#{file}#{append_string}"

    File.rename(file, replace_string)
  end
end
