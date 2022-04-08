class PagesController < ApplicationController
  before_action :authenticate_account!, except: [:show]
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :can_modify?, except: [:show]

  def index
  end

  def show
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: "#{t('page.singular')} #{t('form.created')}" }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: "#{t('page.singular')} #{t('form.updated')}" }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: "#{t('page.singular')} #{t('form.destroyed')}" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.friendly.find(params[:id])
    end

    def can_modify?
      unless current_account.is_admin?
        redirect_to root_url, flash: { danger: t("accounts.permission_denied") } and return
      end
    end

    def page_params
      params.fetch(:page, {}).permit(:name, :body, :url)
    end
end
