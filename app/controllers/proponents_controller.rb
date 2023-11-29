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
# - TODO `edit`: Render a form for editing an existing proponent.
# - TODO `update`: Update an existing proponent based on form submissions.
# - TODO `destroy`: Delete a proponent.
#
class ProponentsController < ApplicationController
  def index
    @proponent_list = ListPresenter.new(proponent_repository.fecth_paginated(page: params[:page]))
  end

  def new
    @proponent_form = ProponentForm.new
  end

  def create
    @proponent_form = ProponentForm.new(proponent_form_attributes)

    if @proponent_form.valid?
      create_proponent
    else
      render :new
    end
  end

  def show
    @proponent_presenter = ProponentPresenter.new(Proponent.find(params[:id]))
  end

  private

  def proponent_repository
    @proponent_repository ||= ProponentRepository.new
  end

  def proponent_form_attributes
    { birthday: build_birthday }.merge proponent_form_params.except('birthday(1i)', 'birthday(2i)', 'birthday(3i)')
  end

  def build_birthday
    year = params[:proponent_form]['birthday(1i)'].to_i
    month = params[:proponent_form]['birthday(2i)'].to_i
    day = params[:proponent_form]['birthday(3i)'].to_i

    Date.new(year, month, day)
  end

  def proponent_form_params
    params.require(:proponent_form).permit(
      :name, :cpf, :birthday, :salary, :inss,
      :street, :number, :district, :city, :state, :zip_code,
      phones: %i[area_code number phone_type]
    )
  end

  def create_proponent
    proponent = Proponent.create(@proponent_form.as_proponent)

    if proponent.save
      redirect_to proponent_path(proponent), notice: 'Proponente criado com sucesso.'
    else
      handle_proponent_creation_error(proponent)
    end
  end

  def handle_proponent_creation_error(proponent)
    @proponent_form.errors.merge!(proponent.errors)
    render :new
  end
end
