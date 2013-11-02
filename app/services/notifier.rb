class Notifier

  attr_reader :model, :user

  def initialize(model, user)
    @model = model
    @user = user
  end

  def create_notification
    begin
      prevent_doubles!
      Notification.create!(notificable: model, user: user)
    rescue ModelAlreadyNotified => e
      # So far, we just silently fail, I don't really know if this is the
      # correct way ...
    end
  end

  def prevent_doubles!
    # Find if there is a notification that already exists for the model or the
    # actual object bound to the model :
    # i.e: if model is a like, a previous like would have been deleted, but as
    # Notifications are never deleted, but if there is a notification, for a
    # Like with the same event_id as `model`, then we should'nt create a new
    # Notification

    # This is tricky, as the conditions has to be done after the join on the table
    # raise ModelAlreadyNotified
  end

end
