module AccountsHelper
  def account_username account
    account.email.present? ? "Welcome back " + account.email.split("@").first.capitalize : "Welcome"
  end
end