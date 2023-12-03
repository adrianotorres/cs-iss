# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      raise ActiveRecord::RecordNotFound
    end
  end

  describe "Error Handling" do
    before { sign_in create(:user) }

    it "rescues from ActiveRecord::RecordNotFound" do
      expect(controller).to rescue_from(ActiveRecord::RecordNotFound)
        .with(:render_not_found)
    end

    it "renders not_found template" do
      get :index
      expect(response).to render_template("errors/not_found")
    end

    it "responds with :not_found status" do
      get :index
      expect(response).to have_http_status(:not_found)
    end
  end
end
