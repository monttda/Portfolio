describe CommentLike do

  let(:the_comment_like) do
    build(:comment_like)
  end

  context 'must respond to' do
    it 'user' do
      expect(the_comment_like).to respond_to (:user)
    end
    it 'comment' do
      expect(the_comment_like).to respond_to (:comment)
    end
  end

  it "When a CommentLike is created it should increase it's associated"\
     " comment points by 1" do
    comment = create(:comment)
    new_like = build(:comment_like, comment: comment)
    expect{new_like.save}.to change{comment.reload.points}.by(1)
  end
end
