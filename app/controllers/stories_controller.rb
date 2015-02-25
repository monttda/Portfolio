class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  @@per_page = 5
  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.order(:updated_at)
    page = params[:page] ? params[:page].to_i : 1
    @stories = @stories.paginate(page: page,
                                 per_page: @@per_page)
  end

  # GET /stories/1
  #
  # @return [Hash<Symbol,ActiveRecord_Associations_CollectionProxy>]
  #  comments_hash: a Hash containing the comments whose parents are the comments
  #  associated to the @story
  # @return [Comment] @comment: new intance of a Comment
  # @return [Story] @story: the Story to be shown
  # @return [ActiveRecord_Associations_CollectionProxy] @comments: all the
  #   comments associated to @story
  #
  def show
    @comments = @story.comments
    @comments_hash = @story.get_comments
    @comment = Comment.new
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:title, :user_id, :text, :url, :points)
    end
end
