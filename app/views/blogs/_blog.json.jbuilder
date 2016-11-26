json.extract! blog, :id, :author, :content, :created_at, :updated_at
json.url blog_url(blog, format: :json)