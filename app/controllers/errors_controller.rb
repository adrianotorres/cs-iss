# frozen_string_literal: true

# ErrorsController
#
# This controller handles custom error pages in your Rails application. It is
# designed to render specific error pages for common HTTP status codes such as
# 404 (Not Found).
#
# The `not_found` action renders the 404 error page when ActiveRecord::RecordNotFound
# exception is encountered. This ensures a user-friendly page is displayed when
# a requested record is not found.
#
# For more information on custom error pages in Rails, refer to the official
# documentation: https://guides.rubyonrails.org/layouts_and_rendering.html#handling-errors
#
class ErrorsController < ApplicationController
  def not_found
    render status: 404
  end
end
