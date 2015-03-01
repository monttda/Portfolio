describe Story do

  ### Stories ###
  let(:the_story){
    build(:story)
  }
  let(:story_with_url){
    build(:story, :with_url)
  }
  let(:story_with_wrong_url){
    build(:story, url: 'www.example.com')
  }
  let(:story_with_text){
    build(:story, :with_text)
  }
  let(:story_with_url_and_text){
    build(:story, :with_url, :with_text)
  }

  let(:story_comment) do
    create(:comment,:with_comments,  story: the_story)
  end

  # Attributes tests
  context 'must respond to' do
    it 'user' do
      expect(the_story).to respond_to (:user)
    end
    it 'text' do
      expect(the_story).to respond_to (:text)
    end
    it 'title' do
      expect(the_story).to respond_to (:title)
    end
    it 'url' do
      expect(the_story).to respond_to (:url)
    end
    it 'created_at' do
      expect(the_story).to respond_to (:created_at)
    end
    it 'updated_at' do
      expect(the_story).to respond_to (:updated_at)
    end
    it 'comments' do
      expect(the_story).to respond_to (:comments)
    end
    it 'story_likes' do
      expect(the_story).to respond_to (:story_likes)
    end
  end

  it '' do
    expect(the_story).to be_valid
  end

  it '' do
    expect(story_with_url).to be_valid
  end

  it '' do
    expect(story_with_text).to be_valid
  end

  it '' do
    expect(story_with_wrong_url).not_to be_valid
  end
  it '' do
    expect(story_with_url_and_text).not_to be_valid
  end

  # Method tests
  describe '#get_comments' do

    context 'should return all the comments associated to the story ' do
      it 'when it has associated comments' do
        story_comment
        comment_child_a = story_comment.comments.first
        comment_child_b = story_comment.comments.last

        expect(the_story.get_comments).to contain_exactly(
          ["#{story_comment.id}", story_comment.comments],
          ["#{comment_child_a.id}", comment_child_a.comments] ,
          ["#{comment_child_b.id}", comment_child_b.comments]
        )
      end

      it 'when it has no associated comments' do
        the_story.save
        expect(the_story.get_comments).to contain_exactly()
      end
    end

  end
end
