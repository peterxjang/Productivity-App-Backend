require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/tasks.json", headers: { "Authorization" => "Bearer #{@token}" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Task.count, data.length
  end

  test "create" do
    assert_difference "Task.count", 1 do
      post "/tasks.json",
        params: {
          title: "test",
          description: "test",
          due_date: Time.now,
          priority: "test",
          status: "test",
          session_id: @session.id,
        },
        headers: { "Authorization" => "Bearer #{@token}" }
      assert_response 200
    end
  end

  test "show" do
    task = Task.create!(
      user_id: @user.id,
      session_id: @session.id,
      title: "Test Task",
      description: "Test Description",
      due_date: Time.now,
      priority: "high",
      status: "pending",
    )

    get "/tasks/#{task.id}.json", headers: { "Authorization" => "Bearer #{@token}" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "user_id", "session_id", "title", "description", "due_date", "priority", "status", "created_at", "updated_at"], data.keys
  end

  test "update" do
    task = Task.create!(
      user_id: @user.id,
      session_id: @session.id,
      title: "Test Task",
      description: "Test Description",
      due_date: Time.now,
      priority: "high",
      status: "pending",
    )

    patch "/tasks/#{task.id}.json",
      params: { title: "Updated title" },
      headers: { "Authorization" => "Bearer #{@token}" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated title", data["title"]
  end

  test "destroy" do
    task = Task.create!(
      user_id: @user.id,
      session_id: @session.id,
      title: "Test Task",
      description: "Test Description",
      due_date: Time.now,
      priority: "high",
      status: "pending",
    )

    assert_difference "Task.count", -1 do
      delete "/tasks/#{task.id}.json", headers: { "Authorization" => "Bearer #{@token}" }
      assert_response 200
    end
  end
end
