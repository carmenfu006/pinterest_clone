class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include RecordHelper

  # This devise helper method applies to after sign up and login
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
end
