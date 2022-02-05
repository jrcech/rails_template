# frozen_string_literal: true

module Elements
  module Navbar
    module LeftNav
      class Component < ViewComponent::Base
        include Utilities::FontAwesomeHelper

        def create_nav_items
          @nav_items = [
            homepage_button,
            users_button,
            articles_button
          ]
        end

        private

        def homepage_button
          controller = 'dashboard'

          {
            path: admin_root_path,
            title: 'Dashboard',
            controller: controller,
            class: "nav-link#{active_class(controller)}"
          }
        end

        def users_button
          controller = 'users'

          {
            path: admin_users_path,
            title: fa_icon(model_icon(:users), text: t('models.users.more')),
            controller: controller,
            class: "nav-link#{active_class(controller)}"
          }
        end

        def articles_button
          controller = 'articles'

          {
            path: admin_articles_path,
            title: fa_icon(model_icon(:articles), text: t('models.articles.more')),
            controller: controller,
            class: "nav-link#{active_class(controller)}"
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
      end
    end
  end
end
