# frozen_string_literal: true

require 'after_do'

Rails::Generators::AppGenerator.extend AfterDo

def hook_before_callback
  Rails::Generators::AppGenerator.before process_methods do |method|
    @process = method.to_s

    say "Running process '#{method.to_s.tr('_', ' ')}'", :yellow
  end
end

def hook_after_callback
  Rails::Generators::AppGenerator.after process_methods do |method|
    say "Process '#{method.to_s.tr('_', ' ')}' finished", :green
  end
end

def process_methods
  methods = []

  Dir[File.join(__dir__, 'processes', '*')].each do |file|
    methods << File.basename(file, '.*').to_sym
  end

  methods
end
