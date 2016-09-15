json.extract! article, :id, :file_article, :user_id, :created_at, :updated_at
json.url article_url(article, format: :json)