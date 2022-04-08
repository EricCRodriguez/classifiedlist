class ApplicationController < ActionController::Base
  before_action :load_app_defaults
  before_action :set_locale

  def can_access?
    unless current_account.admin?
      redirect_to root_url, flash: { danger: t("accounts.permission_denied") } and return
    end
  end

  private

  def load_app_defaults
   @pages = Page.all
   @categories = Category.where(parent_id: nil).order(name: :asc)
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end
end
