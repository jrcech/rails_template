module ButtonsHelper
  def show_button(item)
    {
      action: :show,
      path: send("admin_#{item.model_name.singular}_path", item.id),
      title: t('actions.show'),
      icon: action_icon(:show)
    }
  end

  def new_button(resources)
    {
      action: :new,
      path: send("new_admin_#{resources.to_s.singularize}_path"),
      button_class: 'btn btn-success',
      title: t(
        'actions.new',
        record: t("models.#{resources.to_s.pluralize}.one")
      ),
      icon: action_icon(:new)
    }
  end

  def edit_button(item, button_class = nil)
    {
      action: :edit,
      path: send("edit_admin_#{item.model_name.singular}_path", item.id),
      title: t('actions.edit'),
      button_class: button_class.present? ? button_class : 'btn btn-primary',
      icon: action_icon(:edit)
    }
  end

  def destroy_button(item, button_class = nil)
    {
      action: :destroy,
      path: send("admin_#{item.model_name.singular}_path", item.id),
      title: t('actions.destroy'),
      button_class: button_class.present? ? button_class : 'btn btn-danger',
      icon: action_icon(:destroy),
      data: destroy_button_data(item)
    }
  end

  def destroy_button_data(item)
    model_translation = t("models.#{item.model_name.plural}.one")

    {
      turbo_method: :delete,
      turbo_confirm: t(
        'confirmations.destroy.confirm',
        record: item.title
      ),
      title: t(
        'confirmations.destroy.title',
        model: model_translation
      ),
      commit: t(
        'confirmations.destroy.commit',
        model: model_translation
      ),
      cancel: t('confirmations.destroy.cancel')
    }
  end

  def per_page_button(pagination)
    {
      id: 'Per page',
      toggle_class: 'btn btn-light dropdown-toggle',
      icon: nil,
      title: "#{pagination.vars[:items]} items per page",
      dropdown_items: per_page_dropdown_items(pagination)
    }
  end

  def per_page_dropdown_items(pagination)
    per_page_items = []

    pagination.vars[:per_page].each do |per_page|
      path = request.params.merge({ items: per_page, page: 1 })

      per_page_item = { title: per_page, path: path }

      per_page_items << per_page_item
    end

    per_page_items
  end

  def action_buttons(item)
    [
      {
        id: "show-#{item.id}-dropdown-button",
        dropdown_class: 'dropdown ms-2',
        menu_class: 'dropdown-menu',
        toggle_class: 'btn btn-light btn-lg',
        icon: 'ellipsis-v',
        dropdown_items: [
          edit_button(item, 'dropdown-item text-primary'),
          destroy_button(item, 'dropdown-item text-danger')
        ]
      }
    ]
  end
end
