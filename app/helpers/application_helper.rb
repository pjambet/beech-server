module ApplicationHelper
  def link_to_app
    if @user_agent == :ios
      'beech://'
    else
      '/'
    end
  end
end
