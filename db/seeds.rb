# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create Users
user1 = User.create!(
  name: "John Doe",
  email: "john@example.com",
  password: "password123",
  image_url: "https://randomuser.me/api/portraits/men/1.jpg",
)

user2 = User.create!(
  name: "Jane Smith",
  email: "jane@example.com",
  password: "password123",
  image_url: "https://randomuser.me/api/portraits/women/1.jpg",
)

# Create Sessions
session1 = Session.create!(
  user_id: user1.id,
  started_at: DateTime.now - 2.hours,
  ended_at: DateTime.now - 1.hour,
  duration_minutes: 60,
  session_type: "work",
)

session2 = Session.create!(
  user_id: user2.id,
  started_at: DateTime.now - 3.hours,
  ended_at: DateTime.now - 2.hours,
  duration_minutes: 60,
  session_type: "break",
)

# Create Tasks
Task.create!(
  user_id: user1.id,
  session_id: session1.id,
  title: "Complete Project Proposal",
  description: "Draft and finalize Q1 project proposal",
  due_date: DateTime.now + 2.days,
  priority: "high",
  status: "in_progress",
)

Task.create!(
  user_id: user1.id,
  session_id: session1.id,
  title: "Team Meeting",
  description: "Weekly sync with development team",
  due_date: DateTime.now + 1.day,
  priority: "medium",
  status: "pending",
)

Task.create!(
  user_id: user2.id,
  session_id: session2.id,
  title: "Code Review",
  description: "Review pull requests for frontend features",
  due_date: DateTime.now + 3.days,
  priority: "high",
  status: "pending",
)
