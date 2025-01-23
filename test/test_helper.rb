ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "test_helper"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

class ActionDispatch::IntegrationTest
  def setup
    User.delete_all
    Session.delete_all
    Task.delete_all

    @user = User.create!(
      name: "Test User",
      email: "test@test.com",
      password: "password123",
    )

    post "/login_sessions", params: { email: "test@test.com", password: "password123" }
    @token = JSON.parse(response.body)["jwt"]

    @session = Session.create!(
      user_id: @user.id,
      started_at: Time.current,
      ended_at: Time.current + 1.hour,
      duration_minutes: 60,
      session_type: "work",
    )
  end
end
