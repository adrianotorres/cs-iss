# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Dashboard", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
    driven_by(:rack_test)
  end

  context "navigation" do
    it "should be able to navigate to dashboard page from list and" do
      visit proponents_path

      click_link t("proponents.index.buttons.dashboard")

      expect(page).to have_content(t("dashboards.index.title"))
      expect(page).to have_content(t("dashboards.index.buttons.proponents"))
    end
  end

  context "report" do
    it "should be able to visualize the salary ranges report" do
      create(:proponent, salary: 900)
      2.times { create(:proponent, salary: 1500) }
      3.times { create(:proponent, salary: 2500) }
      4.times { create(:proponent, salary: 5000) }
      5.times { create(:proponent, salary: 7000) }

      visit dashboards_path

      expect(page).to have_content("#{t('dashboards.index.salary_ranges.one')} 1")
      expect(page).to have_content("#{t('dashboards.index.salary_ranges.two')} 2")
      expect(page).to have_content("#{t('dashboards.index.salary_ranges.three')} 3")
      expect(page).to have_content("#{t('dashboards.index.salary_ranges.four')} 4")
      expect(page).to have_content("#{t('dashboards.index.salary_ranges.five')} 5")
    end

    it "should be able to visualize the salary ranges charts" do
      2.times { create(:proponent, salary: 1500) }

      visit dashboards_path

      expect(page.find("#dashboard-pie-chart").present?).to be_truthy
      expect(page.find("#dashboard-column-chart").present?).to be_truthy
    end
  end
end
