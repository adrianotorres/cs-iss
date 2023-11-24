# frozen_string_literal: true

# This class is responsible for presenting a list of items.
#
# Usage:
#   presenter = ListPresenter.new(items)
#
#   # Access the presented items
#   presenter.items
class ListPresenter
  attr_reader :items

  def initialize(items)
    @items = items
  end
end
