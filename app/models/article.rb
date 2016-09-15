class Article < ActiveRecord::Base
  belongs_to :user
  mount_uploader :file_article, AvatarUploader
end
