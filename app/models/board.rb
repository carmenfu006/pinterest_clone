class Board < ApplicationRecord
  belongs_to :user

  has_many :pins

  validates :name, presence: true
end