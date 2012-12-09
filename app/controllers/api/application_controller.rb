class Api::ApplicationController < ApplicationController
  before_filter :authenticate_user!
end
