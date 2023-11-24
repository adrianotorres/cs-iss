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
end
