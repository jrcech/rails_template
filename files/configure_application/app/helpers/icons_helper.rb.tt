module IconsHelper
  def model_icon(model)
    icons = YAML.load_file('config/icons.yml')

    icons['models'][model.to_s]
  end

  def action_icon(model)
    icons = YAML.load_file('config/icons.yml')

    icons['actions'][model.to_s]
  end

  def search_icon(title)
    render(
      Tooltips::TooltipComponent.new(
        icon: 'search',
        title: t('tooltips.search'),
        text_before: title
      )
    )
  end
end
