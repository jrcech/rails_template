# frozen_string_literal: true

module ProcessDecorator
  Dir[File.join(__dir__, 'processes', '**', '*.rb')].each { |f| require f }

  methods = []

  Dir[File.join(__dir__, 'processes', '*')].each do |file|
    methods << File.basename(file, '.*').to_sym
  end

  methods.each do |method|
    define_method method do
      @process = method.to_s

      say "Running process '#{method.to_s.tr('_', ' ')}'", :yellow
      super()
      say "Process '#{method.to_s.tr('_', ' ')}' finished", :green
    end
  end
end
