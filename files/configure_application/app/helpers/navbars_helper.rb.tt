module NavbarsHelper
  def left_nav
    [
      homepage_button,
      users_button,
      articles_button,
      reviews_button,
      comments_button,
      technologies_button
    ]
  end

  def right_nav
    [
      locales_dropdown,
      user_signed_in? ? user_dropdown : login_button
    ]
  end

  def homepage_button
    {
      path: admin_root_path,
      title: 'Dashboard',
      controller: 'dashboard',
      button_class: "nav-link#{active_class('dashboard')}"
    }
  end

  def users_button
    {
      path: admin_users_path,
      icon: model_icon(:users),
      title: t('models.users.more'),
      controller: 'users',
      button_class: "nav-link#{active_class('users')}"
    }
  end

  def articles_button
    {
      path: admin_articles_path,
      icon: model_icon(:articles),
      title: t('models.articles.more'),
      controller: 'articles',
      button_class: "nav-link#{active_class('articles')}"
    }
  end

  def reviews_button
    {
      path: admin_reviews_path,
      icon: model_icon(:reviews),
      title: t('models.reviews.more'),
      controller: 'reviews',
      button_class: "nav-link#{active_class('reviews')}"
    }
  end

  def comments_button
    {
      path: admin_comments_path,
      icon: model_icon(:comments),
      title: t('models.comments.more'),
      controller: 'comments',
      button_class: "nav-link#{active_class('comments')}"
    }
  end

  def technologies_button
    {
      path: admin_technologies_path,
      icon: model_icon(:technologies),
      title: t('models.technologies.more'),
      controller: 'technologies',
      button_class: "nav-link#{active_class('technologies')}"
    }
  end

  def active_class(controller)
    return ' active' if active?(controller)

    nil
  end

  def active?(controller)
    return true if controller_name == controller

    false
  end

  def locales_dropdown
    {
      title: I18n.locale.upcase,
      dropdown_class: 'dropdown nav-item',
      toggle_class: 'nav-link dropdown-toggle',
      element: :li,
      dropdown_items: available_locales
    }
  end

  def user_dropdown
    {
      title: current_user.present? ? UserPresenter.new(record: current_user).full_name : nil,
      menu_class: 'dropdown-menu dropdown-menu-end',
      dropdown_class: 'dropdown nav-item',
      toggle_class: 'nav-link dropdown-toggle',
      element: :li,
      dropdown_items: [
        {
          icon: 'power-off',
          title: 'Sign out',
          size: 'sm',
          path: session_path,
          data: {
            turbo_method: :delete
          }
        },
        {
          title: 'Edit password',
          path: edit_password_path
        }
      ]
    }
  end

  def login_button
    {
      icon: 'sign-in-alt',
      title: 'Log in',
      size: 'sm',
      path: new_session_path,
      button_class: 'nav-link'
    }
  end
end
