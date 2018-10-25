class Kit < ApplicationRecord
  validates :number, presence: true
  validates :name, presence: true
  belongs_to :kit_list
  has_many :items, dependent: :destroy
end
