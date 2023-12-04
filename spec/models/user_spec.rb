# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "Devise modules" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password).on(:create) }
    it { should validate_length_of(:password).is_at_least(Devise.password_length.first).on(:create) }
    it { should validate_length_of(:password).is_at_most(Devise.password_length.last).on(:create) }

    it { should respond_to(:email) }
    it { should respond_to(:encrypted_password) }
    it { should respond_to(:reset_password_token) }
    it { should respond_to(:reset_password_sent_at) }
    it { should respond_to(:remember_created_at) }
  end
end
