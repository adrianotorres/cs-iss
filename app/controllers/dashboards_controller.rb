# frozen_string_literal: true

class DashboardsController < ApplicationController
  def index
    @dashboard_list = ListPresenter.new(proponent_repository.grouped_by_salary_range)
  end

  private def proponent_repository
    @proponent_repository ||= ProponentRepository.new
  end
end
