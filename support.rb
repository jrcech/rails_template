require_relative 'support/commented_files'

def remove_comments_from_files(files, inline: false)
  files.each do |file|
    remove_comments_from_file file, inline: inline
  end
end

def remove_comments_from_file(file, inline: false)
  file_extension = File.extname(file)

  regex =
    case file_extension
    when '.js'
      js_comment_regex
    else
      ruby_comment_regex inline
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
    file_lines += line unless line.include?(term)
  end

  File.open(file, 'w') do |opened_file|
    opened_file.puts file_lines
  end
end

def add_blank_line(file, term)
  file_lines = ''

  IO.readlines(file).each do |line|
    next file_lines += "#{line}\n" if line.include?(term)

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

def unlock_templates(dir)
  Dir.glob(File.join(dir, '**', '*.ttl')).each do |file|
    rename_string = file.gsub('.ttl', '.tt')

    File.rename(file, rename_string)
  end
end

def read_support_file(file)
  File.read(File.join(__dir__, 'support', @process, file))
end

def read_insert_file(file)
  File.read(File.join('./tmp', 'inserts', @process, file))
end

def template_into_file(file, **args)
  insert_into_file file, read_insert_file(file.split('.').first), args
end

def install_gems
  append_to_file 'Gemfile', read_insert_file('Gemfile')

  run 'bundle install'
end

def process_directory
  directory File.join('files', @process), './'
end

def last_end
  /^end/
end

def second_last_end
  /^\s\send/
end

def third_last_end
  /^\s\s\s\send/
end
