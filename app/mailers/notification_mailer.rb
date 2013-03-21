class NotificationMailer < ActionMailer::Base
  default to: -> { default_to }
  default from: 'notifications@getbeech.com'

  def new_beer(beer)
    @beer = beer
    mail(subject: 'New beer suggestion')
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
