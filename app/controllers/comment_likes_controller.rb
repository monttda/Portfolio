class CommentLikesController < ApplicationController
  def create
    @comment_like = CommentLike.new(params.permit(:comment_id, :user_id))
    @comment_like.save
  end
end
