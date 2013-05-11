class Notifier

  attr_reader :model, :user

  def initialize(model, user)
    @model = model
    @user = user
  end

  def create_notification
    Notification.create!(notificable: model, user: user)
  end

end
