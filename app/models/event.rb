class Event < ApplicationRecord
  belongs_to :recordable, polymorphic: true
end
