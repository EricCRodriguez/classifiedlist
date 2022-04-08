class AccountsController < ApplicationController
  before_action :authenticate_account!, except: [:profile]

  def index
    @users = Account.where(admin: false).order(created_at: :desc)
  end

  def destroy_account
    if params[:id].present? && Account.find_by_id(params[:id]).destroy
      redirect_to users_path, notice: "#{t('users.singular')} #{t('form.destroyed')}"
    else
      redirect_to users_path, flash: { danger: t('form.failed') }
    end
  end

  def dashboard
    @posts = current_account.admin? ? Post.order(created_at: :desc).limit(5) : current_account.posts
    @users = Account.order(created_at: :desc).limit(5) if current_account.admin?
  end

end
