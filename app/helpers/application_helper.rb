module ApplicationHelper

  def is_home?
    controller.controller_name == "public" && controller.action_name == "home"
  end

  def entry_type? name
    controller.controller_name == name && controller.action_name == "show"
  end

  def is_auth?
    controller.controller_name == "sessions" || controller.controller_name == "registrations"
  end

  def flash_notifications
    flash_messages = []

    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert' || type == 'danger'
      text = "toastr['#{type}']('#{message}');"
      flash_messages << text.html_safe unless message.blank?
    end

    "<script>$(function(){ #{ flash_messages.join("\n") } });</script>".html_safe if flash_messages.any?
  end

  def page_title
    site_name = ENV.fetch("SITE_NAME") { "Craigslist Clone" }

    if entry_type? "categories"
      page = t("nav.categories." + @category.url, default: @category.name.capitalize)
    elsif entry_type? "pages"
      page = t('nav.sidebar_pages.' + @page.slug, default: @page.name)
    elsif entry_type? "posts"
      page = @post.title
    else
      page = ENV.fetch("HOMEPAGE_TITLE") { "Home" }
    end

     "#{page} | #{site_name}"
  end

end
