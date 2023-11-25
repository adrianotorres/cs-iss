# frozen_string_literal: true

# ApplicationController
#
# This is the base controller for your Rails application. It includes common
# behavior for handling requests and rendering views. You can customize this
# controller or inherit from it to add additional functionality.
#
# The ApplicationController includes a rescue_from hook for handling the
# ActiveRecord::RecordNotFound exception, ensuring that a custom 404 page is
# displayed when a record is not found.
#
# For more information on the Rails ApplicationController, refer to the official
# documentation: https://api.rubyonrails.org/classes/ActionController/Base.html
#
class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_not_found
    render 'errors/not_found', status: 404
  end
end
