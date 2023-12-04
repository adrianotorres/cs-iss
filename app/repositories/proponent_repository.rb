# frozen_string_literal: true

# This class serves as an intermediary to encapsulate the logic for fetching
# paginated data from the `Proponent` model, providing a clean interface
# for working with paginated proponent records.
#
# Usage Example:
# ```ruby
# proponent_repository = ProponentRepository.new
# proponent_repository.fetch_paginated(page: 1, per: 5)
# ```
#
# Methods:
# - `fetch_paginated(page = 1, per = 5)`: Retrieves a paginated list of proponents.
#   - `page` (optional): The page number to fetch. Defaults to 1.
#   - `per` (optional): The number of items per page. Defaults to 5.
class ProponentRepository
  def fecth_paginated(page: 1, per: 5)
    Proponent.page(page).per(per)
  end

  def find(id)
    Proponent.find(id)
  end

  def create(attributes)
    Proponent.create(attributes)
  end

  def update(attributes)
    find(attributes[:id]).update(attributes)
  end

  def destroy(id)
    find(id).destroy
  end

  def grouped_by_salary_range
    Proponent.all.reduce({
                           I18n.t("dashboards.index.salary_ranges.one").to_s => 0,
                           I18n.t("dashboards.index.salary_ranges.two").to_s => 0,
                           I18n.t("dashboards.index.salary_ranges.three").to_s => 0,
                           I18n.t("dashboards.index.salary_ranges.four").to_s => 0,
                           I18n.t("dashboards.index.salary_ranges.five").to_s => 0
                         }) do |grouped, proponent|
      if proponent.salary.to_f <= 1045
        grouped.tap {|g| g[I18n.t("dashboards.index.salary_ranges.one").to_s] += 1 }
      elsif proponent.salary.to_f <= 2089.6
        grouped.tap {|g| g[I18n.t("dashboards.index.salary_ranges.two").to_s] += 1 }
      elsif proponent.salary.to_f <= 3134.4
        grouped.tap {|g| g[I18n.t("dashboards.index.salary_ranges.three").to_s] += 1 }
      elsif proponent.salary.to_f <= 6101.06
        grouped.tap {|g| g[I18n.t("dashboards.index.salary_ranges.four").to_s] += 1 }
      else
        grouped.tap {|g| g[I18n.t("dashboards.index.salary_ranges.five").to_s] += 1 }
      end
    end
  end
end
