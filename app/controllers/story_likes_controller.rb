class StoryLikesController < ApplicationController
  def create
    @story_like = StoryLike.new(params.permit(:story_id, :user_id))
    @story_like.save
  end
end
