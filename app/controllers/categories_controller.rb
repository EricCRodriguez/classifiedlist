class CategoriesController < ApplicationController
  before_action :can_access?, except: [:show]
  before_action :set_category_by_url, only: [:show]
  before_action :set_category_by_id, only: [:edit, :update, :destroy]

  def index
    @categories = Category.where(parent_id: nil).order(name: :asc)
  end

  def show
    category_ids = @category.subcategories.ids
    category_ids << @category.id

    @posts = Post.where(category_id: category_ids)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: "#{t('category.singular')} #{t('form.created')}" }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: "#{t('category.singular')} #{t('form.updated')}" }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: "#{t('category.singular')} #{t('form.destroyed')}" }
      format.json { head :no_content }
    end
  end

  private
    def set_category_by_url
      @category = Category.find_by_url(params[:url])
    end

    def set_category_by_id
      @category = Category.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.fetch(:category, {}).permit(:name, :secondary_name, :url, :parent_id)
    end
end
