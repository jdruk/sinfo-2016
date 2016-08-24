json.extract! course, :id, :name, :type, :created_at, :updated_at
json.url course_url(course, format: :json)