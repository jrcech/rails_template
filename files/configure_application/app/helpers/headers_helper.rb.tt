module HeadersHelper
  def overview_header
    {
      title: 'Overview',
      icon: 'magnifying-glass'
    }
  end

  def index_header(model)
    {
      title: model.to_s.humanize,
      icon: model_icon(model),
      model:
    }
  end

  def header(item)
    {
      title: item.title,
      icon: model_icon(item.model_name.plural),
      model: item.model_name.plural
    }
  end
end
