class Story < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

=begin
    Returns all the comments related to the Story
    @return [Hash<Symbol,ActiveRecord_Associations_CollectionProxy>] a Hash
      containing the comments whose parents are the comments associated to the
      story
=end

    def get_comments
      comments = self.comments.order(:created_at).to_a
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
