class Item < ApplicationRecord
  belongs_to :kit
  validates :name, presence: true
  validates :image, presence: true
  validates :slot, presence: true
end
