class KitList < ApplicationRecord
  has_many :kits, dependent: :destroy
  validates :origin_user, presence: true
  has_many :kit_list_users
  has_many :users, through: :kit_list_users
end
