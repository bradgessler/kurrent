class Message < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :account, default: -> { creator.account }
  has_many :events, as: :recordable
end
