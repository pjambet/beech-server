class NotificationMailer < ActionMailer::Base
  default to: -> { default_to }
  default from: 'notifications@getbeech.com'

  def new_beer(beer)
    @beer = beer
    mail(subject: 'New beer suggestion')
  end

  def accepted_beer(beer)
    @beer = beer
    mail(to: beer.added_by.email, subject: 'Your suggestion has been accepted')
  end

  def new_user(user)
    @user = user
    mail(subject: 'New user')
  end

  private

  def default_to
    if ENV['NOTIFICATIONS_RECIPIENTS']
      ENV['NOTIFICATIONS_RECIPIENTS'].split(',')
    else
      'contact@getbeech.com'
    end
  end
end
