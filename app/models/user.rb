class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :kit_list_users
  has_many :kit_lists, through: :kit_list_users

  # Favorites a kit.
  def favorite(kit_list)
    kit_lists << kit_list
  end

  # Unfollows a user.
  def unfavorite(kit_list)
    kit_lists.delete(kit_list)
  end

  # Returns true if the current user is following the other user.
  def favorited?(kit_list)
    kit_lists.include?(kit_list)
  end

end
