json.array! @users, partial: "users/user", as: :user

json.id user.id
json.name user.name
json.email user.email
json.password_digest user.password_digest
json.image_url user.image_url
json.created_at user.created_at
json.updated_at user.updated_at