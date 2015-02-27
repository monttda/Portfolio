class StoryLike < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  validates :user, presence: true , uniqueness: { scope: :story }
  validates :story, presence: true
  after_create :sum_points

  private
    def sum_points
      story = self.story
      story.update_attribute(:points,story.points+1)
    end
end
