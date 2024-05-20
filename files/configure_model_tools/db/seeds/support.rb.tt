module Support
  def seed(model, find_by:, **attributes)
    log_model_change(model)

    record = model.where(find_by).first_or_initialize(attributes)
    record.save!

    log('.')

    @last_model = model
  end

  private

  def log_model_change(model)
    return if model == @last_model

    log("\nSeeding: #{model}")
  end

  def log(message)
    $stdout.print message
  end
end
