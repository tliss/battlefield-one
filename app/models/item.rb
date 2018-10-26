class Item < ApplicationRecord
  belongs_to :kit
  validates :name, presence: true
  validates :image, presence: true
  validates :slot, presence: true
  default_scope -> { order(slot: :asc) }
end
