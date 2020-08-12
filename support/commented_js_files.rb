# frozen_string_literal: true

module CommentedJsFiles
  def self.list
    %w[
      app/javascript/channels/consumer.js
      app/javascript/channels/index.js
      app/javascript/controllers/index.js
      app/javascript/packs/application.js
    ]
  end
end
