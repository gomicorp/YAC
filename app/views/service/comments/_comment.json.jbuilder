json.extract! comment, :id, :rating, :hide_at, :remote_ip, :post_id, :author_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
