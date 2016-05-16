class Deck < ActiveRecord::Base
  has_many   :cards
  belongs_to :user

  validates :name, :user_id, presence: true

end
