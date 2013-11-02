class MailPreview < MailView

  def new_beer
    beer = Beer.first
    NotificationMailer.new_beer(beer)
  end

  def accepted_beer
    beer = Beer.first
    NotificationMailer.accepted_beer(beer)
  end

end
