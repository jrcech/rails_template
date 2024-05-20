class ModelPresenter
  include ActionView::Helpers

  delegate_missing_to :record

  def initialize(record:, search_query: nil)
    @record = record
    @search_query = search_query
  end

  def model_symbol
    record.class.name.underscore
  end

  def model_symbol_plural
    record.class.name.underscore.pluralize
  end

  private

  attr_reader :record, :search_query
end
