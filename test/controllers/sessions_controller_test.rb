require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/sessions.json", headers: { "Authorization" => "Bearer #{@token}" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Session.count, data.length
  end

  test "create" do
    assert_difference "Session.count", 1 do
      post "/sessions.json",
        params: {
          started_at: Time.current,
          ended_at: Time.current + 1.hour,
          duration_minutes: 60,
          session_type: "work",
        },
        headers: { "Authorization" => "Bearer #{@token}" }
      assert_response 200
    end
  end

  test "show" do
    session = Session.create!(
      user_id: @user.id,
      started_at: Time.current,
      ended_at: Time.current + 1.hour,
      duration_minutes: 60,
      session_type: "work",
    )
    get "/sessions/#{session.id}.json", headers: { "Authorization" => "Bearer #{@token}" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "user_id", "started_at", "ended_at", "duration_minutes", "session_type", "created_at", "updated_at"], data.keys
  end

  test "update" do
    patch "/sessions/#{@session.id}.json",
      params: { session_type: "Updated session type" },
      headers: { "Authorization" => "Bearer #{@token}" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated session type", data["session_type"]
  end

  test "destroy" do
    session = Session.create!(
      user_id: @user.id,
      started_at: Time.current,
      ended_at: Time.current + 1.hour,
      duration_minutes: 60,
      session_type: "work",
    )
    assert_difference "Session.count", -1 do
      delete "/sessions/#{session.id}.json", headers: { "Authorization" => "Bearer #{@token}" }
      assert_response 200
    end
  end
end
