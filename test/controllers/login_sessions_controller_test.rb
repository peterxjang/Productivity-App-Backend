require "test_helper"

class LoginSessionsControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    User.create!(
      name: "Test",
      email: "test2@test.com",
      password: "password",
      password_confirmation: "password",
      image_url: "image.png",
    )

    post "/login_sessions.json",
      params: { email: "test2@test.com", password: "password" }
    assert_response 201

    data = JSON.parse(response.body)
    assert_equal ["email", "user_id"], data.keys
  end

  test "destroy" do
    delete "/login_sessions.json"
    assert_response 200
  end
end
