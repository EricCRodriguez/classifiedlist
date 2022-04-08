class LanguagesController < ApplicationController

  def set_locale
    I18n.locale = params[:language].to_sym
    session[:locale] = I18n.locale
  end

end
