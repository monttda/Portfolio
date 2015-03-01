describe StoryLike do
  let(:the_story_like) do
    build(:story_like)
  end
  context 'must respond to' do
    it 'user' do
      expect(the_story_like).to respond_to (:user)
    end
    it 'story' do
      expect(the_story_like).to respond_to (:story)
    end
  end

  it "When a StoryLike is created it should increase it's associated"\
     " story points by 1" do
    story = create(:story)
    new_like = build(:story_like, story: story)
    expect{new_like.save}.to change{story.reload.points}.by(1)
  end
end
