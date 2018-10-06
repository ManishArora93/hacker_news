class ReadAndDeleted < ApplicationRecord
  belongs_to :user

  #Scopes
  scope :deleted, -> {where(action_type: "deleted")}
  scope :read, -> {where(action_type: "read")}
end
