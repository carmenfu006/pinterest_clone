class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include RecordHelper

  def turbo_flash(flash_message)
    # Add some logic to only replace if there is a flash, add error flashes, etc
    turbo_stream.update("flash", partial: "shared/flash", locals: { flash: flash_message })
  end

  # This devise helper method applies to after sign up and login
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
end
