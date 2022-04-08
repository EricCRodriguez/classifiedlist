class PublicController < ApplicationController

  def home
  end

  def send_enquiry_to_user
    @post = Post.find(params[:post_id])

    if @post.present?
      ContactMailer.post_enquiry(@post.id, params[:email], params[:message]).deliver_now
      flash[:success] = t("post.send_message_success")
    else
      flash[:danger] = t("post.send_message_fail")
    end

    redirect_to post_path(@post)
  end

  def faqs
  end

  def scams
  end

  def safety
  end

  def terms
  end

end
