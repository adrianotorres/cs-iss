# frozen_string_literal: true

require "rails_helper"

RSpec.describe "DestroyProponents", type: :system do
  before { sign_in create(:user) }

  context "destroy" do
    it "should be able to destroy a proponent" do
      proponent = create(:proponent)
      visit proponents_path

      click_button t("proponents.index.table.buttons.destroy")

      expect(page).to have_content(t("proponents.messages.destroy_successfully"))
      expect(page).to have_content(t("proponents.index.table.empty"))
      expect { ProponentRepository.new.find(proponent.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should be able to destroy if proponent had already destroyed" do
      create(:proponent)
      allow_any_instance_of(DestroyProponent).to receive(:destroy).and_return({status: :error})

      visit proponents_path
      click_button t("proponents.index.table.buttons.destroy")

      expect(page).to have_content(t("proponents.messages.destroy_failure"))
    end
  end
end
