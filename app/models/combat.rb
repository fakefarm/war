class Combat < ApplicationRecord
  validates :seed_number, presence: true

  has_many :players
end
