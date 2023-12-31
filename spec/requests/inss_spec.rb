# frozen_string_literal: true

require "rails_helper"

RSpec.describe InssController, type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "POST #calculate" do
    it "calculates INSS discount and returns JSON response" do
      salary = 3000.0
      post "/inss/calculate", params: {salary:}

      expect(response).to have_http_status(:ok)

      json_response = response.parsed_body

      expect(json_response).to have_key("discount")
      expect(json_response["discount"]).to be_a(Float)
      expect(json_response["discount"]).to eq(281.62)
    end
  end
end
