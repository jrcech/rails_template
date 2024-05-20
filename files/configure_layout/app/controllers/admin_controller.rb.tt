class AdminController < ApplicationController
  before_action :authenticate_user!

  private

  def scope_method
    return :"for_#{parent_name}" if controller_nested?

    nil
  end

  def parent_record
    parent_name.classify.safe_constantize.find(parent_id)
  end

  def parent_presenter
    "#{parent_name.classify}Presenter".safe_constantize
  end

  def parent_id
    params[parent_param]
  end

  def parent_name
    parent_param.gsub('_id', '')
  end

  def parent_param
    params.keys.find { |key| key.to_s.include?('_id') }
  end

  def controller_nested?
    parent_param.present?
  end
end
