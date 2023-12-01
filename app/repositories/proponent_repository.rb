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

  def grouped_by_salary_range
    Proponent.all.reduce({
                           one: 0,
                           two: 0,
                           three: 0,
                           four: 0,
                           five: 0
                         }) do |grouped, proponent|
      if proponent.salary <= 1045
        grouped.tap {|g| g[:one] += 1 }
      elsif proponent.salary <= 2089.6
        grouped.tap {|g| g[:two] += 1 }
      elsif proponent.salary <= 3134.4
        grouped.tap {|g| g[:three] += 1 }
      elsif proponent.salary <= 6101.06
        grouped.tap {|g| g[:four] += 1 }
      else
        grouped.tap {|g| g[:five] += 1 }
      end
    end
  end
end
