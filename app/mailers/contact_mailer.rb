class ContactMailer < ApplicationMailer

  def post_enquiry(post_id, reply_to_email, message)
    post = Post.find(post_id)

    if post.present?
      account = post.account
      @post_title = post.title
      @message = message
      @reply_to_email = reply_to_email

      # send mail to post author
      if account.present?
        mail(to: account.email, subject: "Enquiry about #{@post_title}")
      end
    end
  end
end
