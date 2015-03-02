class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  belongs_to :parent, class_name: "Comment"
  has_many :comment_likes, dependent: :destroy
  has_many :comments, foreign_key: "parent_id", dependent: :destroy
  validates :user, presence: true
  validates :text, presence: true
  validates :story, presence: true


=begin
    Returns all the comments related to the Comment
    @return [Hash<Symbol,ActiveRecord_Associations_CollectionProxy>] a Hash
      containing the comments whose parents are the comments associated to the
      story
=end

    def get_comments
      comments = self.comments.where(parent_id: nil).order(:created_at).to_a
      comments_hash = {}
      while comments.any? do
        comment = comments.shift
        comment_comments = comment.comments.order(:created_at)
        comments_hash["#{comment.id}"] = comment_comments
        comments.concat(comment_comments)
      end
      comments_hash
    end
end
