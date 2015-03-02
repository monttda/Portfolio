class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :create, :new]
  @@per_page = 10
  # GET /stories
  # @return [Story::ActiveRecord_Relation] @stories: the stories to be shown in
  #         ordered and paginated
  # @return [Set<Integer>] @liked_stories: the liked stories by the current user
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



  # GET /user_stories
  # @return [Story::ActiveRecord_Relation] @stories: the stories to be shown in
  #         ordered and paginated
  # @return [Set<Integer>] @liked_stories: the liked storiesby the current user
  #
  def user_stories
    @stories = Story.where(user: current_user).order(created_at: :desc)
    page = params[:page] ? params[:page].to_i : 1
    @stories = @stories.paginate(page: page,
                                 per_page: @@per_page)
    if user_signed_in?
      @liked_stories = Set.new(current_user.story_likes.pluck(:story_id))
    else
      @liked_stories = Set.new
    end

    render :index
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
    @comments = @story.comments.where(parent_id: nil)
    @comments_hash = @story.get_comments
    @comment = Comment.new
    if user_signed_in?
      @liked = current_user.story_likes
                           .find_by(story: @story) ? true : false
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
  # @return [Story] @story: the Story to be edited
  def edit
  end

  # POST /stories
  # @return [Story] @story: the Story to be created
  def create
    @story = Story.new(story_params.merge({points: 0}))
    if @story.save
      flash[:notice] = t('story.notices.create')
      redirect_to @story
    else
      render :new
    end
  end

  # PATCH/PUT /stories/:id
  def update
    if @story.update(story_params)
      flash[:notice] = t('story.notices.update')
      redirect_to story_path(@story)
    else
      render :edit
    end

  end

  # DELETE /stories/:id
  def destroy
    @story.destroy
    redirect_to stories_url, notice: t('story.notices.destroy')
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
