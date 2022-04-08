class PostsController < ApplicationController
  before_action :authenticate_account!, except: [:show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :can_modify_post?, except: [:index, :new, :show, :create]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.account_id = current_account.id if account_signed_in?

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "#{t('post.singular')} #{t('form.created')}" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "#{t('post.singular')} #{t('form.updated')}" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "#{t('post.singular')} #{t('form.destroyed')}" }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def can_modify_post?
      unless current_account.id == @post.account_id || current_account.admin?
        redirect_to root_url, flash: { danger: t("accounts.permission_denied") } and return
      end
    end

    def post_params
      params.fetch(:post, {}).permit(:title, :content, :address, :category_id, images: [])
    end
end
