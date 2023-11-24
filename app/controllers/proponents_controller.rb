# frozen_string_literal: true

# ProponentsController
#
# The ProponentsController handles the CRUD operations for proponents.
#
# Actions:
# - `index`: Display a paginated list of all proponents.
# - TODO `show`: Display details of a specific proponent.
# - TODO `new`: Render a form for creating a new proponent.
# - TODO `create`: Create a new proponent based on form submissions.
# - TODO `edit`: Render a form for editing an existing proponent.
# - TODO `update`: Update an existing proponent based on form submissions.
# - TODO `destroy`: Delete a proponent.
#
class ProponentsController < ApplicationController
  def index
    @proponent_list = ListPresenter.new(proponent_repository.fecth_paginated(page: params[:page]))
  end

  private

  def proponent_repository
    @proponent_repository ||= ProponentRepository.new
  end
end
