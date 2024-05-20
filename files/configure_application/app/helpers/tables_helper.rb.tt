module TablesHelper
  def index_data(records, *columns)
    collection = []

    records.each do |record|
      item_presenter = "#{record.class}Presenter".constantize.new(
        record:,
        search_query: @search_query
      )

      cells = item_cells(item_presenter, columns)

      cells << index_buttons(item_presenter)

      collection << { cells:, show_path: send("admin_#{item_presenter.model_name.singular}_path", record) }
    end

    collection
  end

  def item_cells(item_presenter, columns)
    cells = []

    columns.each do |cell|
      cells << item_presenter.send(cell)
    end

    cells
  end

  def index_buttons(item_presenter)
    render Buttons::DropdownComponent.new(
      id: "#{item_presenter.id}-dropdown-button",
      menu_class: 'dropdown-menu dropdown-menu-end',
      toggle_class: 'btn btn-light float-end',
      icon: 'ellipsis-v',
      dropdown_items: [
        show_button(item_presenter),
        edit_button(item_presenter, 'dropdown-item text-primary'),
        destroy_button(item_presenter, 'dropdown-item text-danger')
      ]
    )
  end
end
