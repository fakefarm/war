class Character < ApplicationRecord
  validates :hero, :description, presence: true
  has_many :players, through: :combats
end
