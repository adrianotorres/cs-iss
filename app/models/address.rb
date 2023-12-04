# frozen_string_literal: true

# Address
# The `Address` model represents address information associated with a Proponent.
#
# Attributes:
# - `street: String` - Street or thoroughfare of the address.
# - `number: String` - Address number.
# - `district: String` - District or neighborhood of the address.
# - `city: String` - City of the address.
# - `state: String` - State of the address.
# - `zip_code: String` - ZIP code of the address.
#
# Usage Example:
# ```ruby
# address = Address.new(
#   street: "123 Main Street",
#   number: "42",
#   district: "Downtown",
#   city: "Metropolis",
#   state: "CA",
#   zip_code: "12345"
# )
# ```
# A Proponent can have an associated address, including street, number,
# district, city, state, and ZIP code information. Through the association,
# we can access the address of a proponent using proponent.address.
class Address < ApplicationRecord
  belongs_to :proponent

  validates :street, :number, :district, :city, :state, presence: true
end
