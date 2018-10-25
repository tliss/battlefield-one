class KitList < ApplicationRecord
  has_many :kits, dependent: :destroy
  validates :origin_user, presence: true
end
