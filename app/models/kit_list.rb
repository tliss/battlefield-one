class KitList < ApplicationRecord
  has_many :kits, dependent: :destroy
end
