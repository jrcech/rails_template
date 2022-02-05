# frozen_string_literal: true

module Elements
  module Buttons
    module Button
      module Actions
        module Role
          private

          def role_button
            return nil if item == current_user
            return nil if item.has_cached_role? :owner

            @role = item.to_role
            {
              action: "make_#{@role}".to_sym,
              path: send("make_#{@role}_admin_user_path", item),
              title: t("actions.make_#{@role}"),
              icon: action_icon("make_#{@role}"),
              data: role_button_data
            }
          end

          def role_button_data
            {
              turbo: false,
              title: t(
                "confirmations.make_#{role}.title",
                item: t("models.#{model_plural_symbol}.one")
              ),
              confirm: t("confirmations.make_#{role}.confirm", item: item.title),
              commit: t("confirmations.make_#{role}.commit"),
              cancel: t("confirmations.make_#{role}.cancel")
            }
          end
        end
      end
    end
  end
end
