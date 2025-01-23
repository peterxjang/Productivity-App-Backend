class CreateSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :duration_minutes
      t.string :session_type

      t.timestamps
    end
  end
end
