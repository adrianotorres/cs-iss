# frozen_string_literal: true

# ProponentsController
#
# The ProponentsController handles the CRUD operations for proponents.
#
# Actions:
# - `index`: Display a paginated list of all proponents.
# - `show`: Display details of a specific proponent.
# - `new`: Render a form for creating a new proponent.
# - `create`: Create a new proponent based on form submissions.
# - `edit`: Render a form for editing an existing proponent.
# - `update`: Update an existing proponent based on form submissions.
# - `destroy`: destroy a proponent.
#
class ProponentsController < ApplicationController
  def index
    @proponent_list = ListPresenter.new(proponent_repository.fecth_paginated(page: params[:page]))
  end

  def show
    @proponent_presenter = ProponentPresenter.new(proponent)
  end

  def new
    @proponent_form = ProponentForm.new
  end

  def edit
    @proponent_form = ProponentForm.from(proponent)
  end

  def create
    @proponent_form = ProponentForm.new(proponent_form_attributes)
    create_proponent_response = CreateProponent.new(@proponent_form).create

    if create_proponent_response[:status] == :success
      redirect_to proponent_path(create_proponent_response[:proponent]),
                  notice: t("proponents.messages.create_successfully")
    else
      render :new
    end
  end

  def update
    @proponent_form = ProponentForm.new(proponent_form_attributes)
    update_proponent_response = UpdateProponent.new(@proponent_form).update

    if update_proponent_response[:status] == :success
      redirect_to proponents_path, notice: t("proponents.messages.update_successfully")
    else
      render :new
    end
  end

  def destroy
    destroy_proponent_response = DestroyProponent.new(params[:id]).destroy

    if destroy_proponent_response[:status] == :success
      redirect_to proponents_path, notice: t("proponents.messages.destroy_successfully")
    else
      redirect_to proponents_path, notice: t("proponents.messages.destroy_failure")
    end
  end

  private def proponent_repository
    @proponent_repository ||= ProponentRepository.new
  end

  private def proponent
    @proponent ||= proponent_repository.find(params[:id])
  end

  private def proponent_form_attributes
    {birthday: build_birthday}.merge proponent_form_params.except(
      "birthday(1i)", "birthday(2i)", "birthday(3i)"
    )
  end

  private def build_birthday
    year = params[:proponent_form]["birthday(1i)"].to_i
    month = params[:proponent_form]["birthday(2i)"].to_i
    day = params[:proponent_form]["birthday(3i)"].to_i

    Date.new(year, month, day)
  end

  private def proponent_form_params
    params.require(:proponent_form).permit(
      :id, :name, :cpf, :birthday, :salary, :inss,
      :street, :number, :district, :city, :state, :zip_code,
      personal: %i[area_code number phone_type],
      reference: %i[area_code number phone_type]
    )
  end
end
