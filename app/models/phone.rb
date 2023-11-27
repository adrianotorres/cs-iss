# frozen_string_literal: true

# Model for storing phone information associated with a proponent.
#
# Attributes:
# - `area_code`: The area_code code of the phone.
# - `number`: The number of the phone.
# - `type`: The type of the phone, it can be personal(0) or reference(1), default is 0.
#
# Usage Example:
# ```ruby
# phone = Phone.new(area_code: "85", number: "99999-9999", type: )
# ```
#
# Validations:
# - `area_code`: Must be present.
# - `number`: Must be present.
#
class Phone < ApplicationRecord
  belongs_to :proponent

  enum phone_type: { personal: 0, reference: 1 }

  validates :area_code, :number, :phone_type, presence: true
end
