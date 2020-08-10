class Board < ApplicationRecord
  acts_as_paranoid

  has_many :posts

  has_many :board_masters
  has_many :users, through: :board_masters

  has_many :favorite_boards
  # has_many :favorited_users, class_name: "User", through: :favorite_boards
  has_many :favorited_users, through: :favorite_boards, source: :user
  # has_many :posts, dependent: :destroy
  validates :title, presence: true, length: { minimum: 2 }

  # default_scope { where(deleted_at: nil) }
  # scope :available, -> { where(deleted_at: nil) }

  # def destroy
  #   update(deleted_at: Time.now)
  # end

  def favorited_by?(u)
    favorited_users.include?(u)
  end
end
