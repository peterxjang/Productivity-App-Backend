class Session < ApplicationRecord
  belongs_to :user
  has_many :tasks
  validates :started_at, presence: true
  validates :ended_at, presence: true
  validates :duration_minutes, presence: true
  validates :session_type, presence: true
end
