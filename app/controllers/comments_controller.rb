class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create]
  @@per_page = 10
  # GET /comments
  # @return [Comment::ActiveRecord_Relation] @comments: the comments to be shown
  #          in ordered and paginated
  # @return [Set<Integer>] @liked_comments: the liked comments by the current user
  #
  def index
    @comments = Comment.order(created_at: :desc)
    page = params[:page] ? params[:page].to_i : 1
    @comments = @comments.paginate(page: page,
                                 per_page: @@per_page)
    if user_signed_in?
      @liked_comments = Set.new(current_user.comment_likes.pluck(:comment_id))
    else
      @liked_comments = Set.new
    end
  end

  # GET /user_comments
  # @return [Comment::ActiveRecord_Relation] @comments: the comments to be shown
  #          in ordered and paginated
  # @return [Set<Integer>] @liked_comments: the liked comments by the current user
  #
  def user_comments
    @comments = Comment.where(user: current_user).order(created_at: :desc)
    page = params[:page] ? params[:page].to_i : 1
    @comments = @comments.paginate(page: page,
                                 per_page: @@per_page)
    if user_signed_in?
      @liked_comments = Set.new(current_user.comment_likes.pluck(:comment_id))
    else
      @liked_comments = Set.new
    end
    render :index
  end

  # GET /comments/:id
  #
  # @return [Hash<Symbol,ActiveRecord_Associations_CollectionProxy>]
  #  comments_hash: a Hash containing the comments whose parents are the comments
  #  associated to the @comment
  # @return [Comment] @new_comment: new intance of a Comment
  # @return [Comment] @comment: the Comment to be shown
  # @return [ActiveRecord_Associations_CollectionProxy] @comments: all the
  #   comments associated to @comment
  # @return [Boolean] @liked: if @comment has already been liked
  # @return [Set<Integer>] @liked_comments: the liked comments but the current
  #          user
  def show
    @comments = @comment.comments
    @comments_hash = @comment.get_comments
    @new_comment = Comment.new
    if user_signed_in?
      @liked = current_user.comment_likes
                           .find_by(comment: @comment) ? true : false
      @liked_comments = Set.new(current_user.comment_likes.pluck(:comment_id))
    else
      @liked = false
      @liked_comments = Set.new
    end
  end

  # GET /comments/:id/edit
  # @return [Comment] @comment: the Comment to be edited
  def edit
  end

  # POST /comments
  # return [Comment] @comment: the comment instance that was tried to save
  #
  def create
    @comment = Comment.new(comment_params.merge({points: 0}))
    if @comment.save
      flash[:notice] = t('comment.notices.create')
    else
      flash[:alert] = ""
      @comment.errors.full_messages.each do |message|
        flash[:alert] += "#{message} \n"
      end

    end

    redirect_to :back
  end

  # PATCH/PUT /comments/:id
  # @return [Comment] @comment: the Comment to be updated
  def update
    if @comment.update(comment_params)
      flash[:notice] = t('comment.notices.update')
      redirect_to comments_path(@comment)
    else
      render :edit
    end
  end

  # DELETE /comments/:id
  #
  # @return [Comment] @comment: the Comment to be deestroyed
  def destroy
    @comment.destroy
    flash[:notice] = t('comment.notices.destroy')
    redirect_to comments_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :text, :parent_id, :story_id)
    end
end
