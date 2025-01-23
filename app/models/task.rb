class Task < ApplicationRecord
  belongs_to :user
  belongs_to :session
  validates :title, presence: true
  validates :description, presence: true
  validates :due_date, presence: true
  validates :priority, presence: true
  validates :status, presence: true
end
