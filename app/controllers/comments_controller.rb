class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  @@per_page = 5
  # GET /comments
  # GET /comments.json
  # @return [Set<Integer>] @liked_comments: the liked comments but the current
  #   
  def index
    @comments = Comment.order(created_at: :desc)
    page = params[:page] ? params[:page].to_i : 1
    @comments = @comments.paginate(page: page,
                                 per_page: @@per_page)
    @liked_comments = Set.new(current_user.comment_likes.pluck(:comment_id))
  end

  # GET /comments/1
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
    @liked = current_user.comment_likes
                         .find_by(comment: @comment) ? true : false
    @liked_comments = Set.new(current_user.comment_likes.pluck(:comment_id))
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # return [Comment] @comment: the comment instance that was tried to save
  #
  def create
    @comment = Comment.new(comment_params.merge({points: 0}))
    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:alert] = ""
      @comment.errors.full_messages.each do |message|
        flash[:alert] += "#{message} \n"
      end

    end

    redirect_to :back
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
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
