class KitListUser < ApplicationRecord
    belongs_to :user
    belongs_to :kit_list
end
