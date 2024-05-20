class UserPresenter < ModelPresenter
  def full_name
    "#{first_name} #{last_name}"
  end

  def highlight_full_name
    highlight(full_name, search_query)
  end

  def highlight_email
    highlight(email, search_query)
  end
end
