# frozen_string_literal: true

def remove_file_comments(file, options = {})
  if options[:delete_blank_lines]
    regex = /^\s*#.*$\n/
  else
    regex = /^[ ]*#.*$\n/
  end

  gsub_file(file, regex, '')
end

def remove_js_file_comments(file, options = {})
  if options[:delete_blank_lines]
    regex = /^\s*\/\/.*$\n/
  else
    regex = /^[ ]*\/\/.*$\n/
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
  files = File.join(dir, '**', '*.rb')

  Dir.glob(files).each do |file|
    replace_string = "#{file}#{append_string}"

    File.rename(file, replace_string)
  end
end
