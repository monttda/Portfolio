class StoryLikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @story_like = StoryLike.new(params.permit(:story_id).merge({user_id: current_user.id}))
    @story_like.save
  end
end
