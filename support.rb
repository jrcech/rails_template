# frozen_string_literal: true

require_relative 'support/commented_files'
require_relative 'support/yarn_dev_packages'
require_relative 'support/yarn_packages'

def remove_comments_from_files(files, inline = false)
  files.each do |file|
    remove_comments_from_file file, inline
  end
end

def remove_comments_from_file(file, inline = false)
  file_extension = File.extname(file)

  case file_extension
  when '.rb', '.yml'
    regex = ruby_comment_regex inline
  when '.js'
    regex = js_comment_regex
  else
    regex = ruby_comment_regex inline
  end

  gsub_file file, regex, ''
end

def ruby_comment_regex(inline)
  return /#[\w\s]*\./ if inline.present?

  /^\s*#.*$\n/
end

def js_comment_regex
  /^\s*\/\/.*$\n/
end

def remove_lines(file, term)
  file_lines = ''

  IO.readlines(file).each do |line|
    file_lines += line unless line.include? term
  end

  File.open(file, 'w') do |opened_file|
    opened_file.puts file_lines
  end
end

def add_blank_line(file, term)
  file_lines = ''

  IO.readlines(file).each do |line|
    next file_lines += "#{line}\n" if line.include? term

    file_lines += line
  end

  File.open(file, 'w') do |opened_file|
    opened_file.puts file_lines
  end
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
