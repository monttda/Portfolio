class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  belongs_to :parent, class_name: "Comment"
  has_many :comments, foreign_key: "parent_id"
end
