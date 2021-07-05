# frozen_string_literal: true

module ProcessDecorator
  Dir[File.join(__dir__, 'processes', '**', '*.rb')].each { |f| require f }

  process_methods = []

  Dir[File.join(__dir__, 'processes', '*')].each do |file|
    process_methods << File.basename(file, '.*').to_sym
  end

  process_methods.each do |method|
    define_method method do
      @process = method.to_s

      say "Running process '#{method.to_s.tr('_', ' ')}'", :yellow
      super()
      say "Process '#{method.to_s.tr('_', ' ')}' finished", :green
    end
  end
end
