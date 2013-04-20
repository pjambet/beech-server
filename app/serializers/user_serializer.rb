class UserSerializer < ActiveModel::Serializer
  include Serializable

  serialiaze_image_as :avatar

  embed :ids, include: true

  attributes :id, :email, :nickname, :avatar_url, :already_following, :authentication_token

  def avatar_url
    image_url
  end

  def include_authentication_token?
    # If action was successful signed in
    path_segment = @options[:url_options][:_path_segments]
    return false unless path_segment
    @options[:status] == 201 && path_segment[:action] == 'create' && path_segment[:controller] == 'users/sessions'
  end
end

