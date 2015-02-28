class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create, :new]
  @@per_page = 5
  # GET /stories
  # @return [Story::ActiveRecord_Relation] @stories: the stories to be shown in
  #         ordered and paginated
  # @return [Set<Integer>] @liked_stories: the liked stories but the current
  #
  def index
    @stories = Story.order(created_at: :desc)
    page = params[:page] ? params[:page].to_i : 1
    @stories = @stories.paginate(page: page,
                                 per_page: @@per_page)
    if user_signed_in?
      @liked_stories = Set.new(current_user.story_likes.pluck(:story_id))
    else
      @liked_stories = Set.new
    end
  end

  # GET /stories/:id
  #
  # @return [Hash<Symbol,ActiveRecord_Associations_CollectionProxy>]
  #  comments_hash: a Hash containing the comments whose parents are the comments
  #  associated to the @story
  # @return [Comment] @comment: new intance of a Comment
  # @return [Story] @story: the Story to be shown
  # @return [Comment::ActiveRecord_Associations_CollectionProxy] @comments: all the
  #   comments associated to @story
  # @return [Boolean] @liked: if @story has already been liked
  # @return [Set<Integer>] @liked_comments: the liked comments but the current
  #          user
  def show
    @comments = @story.comments
    @comments_hash = @story.get_comments
    @comment = Comment.new
    if user_signed_in?
      @liked = current_user.comment_likes
                           .find_by(comment: @comment) ? true : false
      @liked_comments = Set.new(current_user.comment_likes.pluck(:comment_id))
    else
      @liked = false
      @liked_comments = Set.new
    end
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/:id/edit
  def edit
  end

  # POST /stories
  def create
    @story = Story.new(story_params.merge({points: 0}))

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /stories/1
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /stories/1
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:title, :user_id, :text, :url)
    end
end
