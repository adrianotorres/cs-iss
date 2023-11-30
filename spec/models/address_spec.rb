# frozen_string_literal: true

require "rails_helper"

RSpec.describe Address, type: :model do
  describe "relations" do
    it { should belong_to(:proponent) }
  end

  describe "validations" do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:district) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
  end
end
