class Board < ApplicationRecord
  validates :title, presence: true, length: {minimum: 2}
  
  def destroy
    update(deleted_at: Time.now)
  end
end
