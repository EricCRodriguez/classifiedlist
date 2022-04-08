class AdminController < ApplicationController
  before_action :is_admin?

  def dashboard
  end

  private

  def is_admin?
    account_signed_in? && current_account.admin?
  end

end
