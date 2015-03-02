class CommentLikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment_like = CommentLike.new(params.permit(:comment_id).merge({user_id: current_user.id}))
    @comment_like.save
  end
end
