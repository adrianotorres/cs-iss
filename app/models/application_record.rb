# frozen_string_literal: true

# ApplicationRecord is the base class for all models in the Rails application.
# It inherits from ActiveRecord::Base and is designated as the primary
# abstract class. As a central component of the ActiveRecord framework,
# ApplicationRecord provides common functionality and settings for models,
# such as database connections and query interfaces.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
