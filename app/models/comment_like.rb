class CommentLike < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment

  validates :user, presence: true , uniqueness: { scope: :comment }
  validates :comment, presence: true
  after_create :sum_points

  private
    def sum_points
      comment = self.comment
      comment.update_attribute(:points,comment.points+1)
    end
end
