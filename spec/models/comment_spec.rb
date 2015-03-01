describe Comment do
  let(:the_comment){
    build(:comment)
  }
  let(:comment_child) do
    create(:comment,:with_comments, parent: the_comment)
  end

  context 'must respond to' do
    it 'user' do
      expect(the_comment).to respond_to (:user)
    end
    it 'text' do
      expect(the_comment).to respond_to (:text)
    end
    it 'parent' do
      expect(the_comment).to respond_to (:parent)
    end
    it 'created_at' do
      expect(the_comment).to respond_to (:created_at)
    end
    it 'updated_at' do
      expect(the_comment).to respond_to (:updated_at)
    end
    it 'comments' do
      expect(the_comment).to respond_to (:comments)
    end
    it 'comment_likes' do
      expect(the_comment).to respond_to (:comment_likes)
    end
  end

  it '' do
    expect(the_comment).to be_valid
  end

  # Method tests
  describe '#get_comments' do

    context 'should return all the comments associated to the comment ' do
      it 'when it has associated comments' do
        comment_child
        comment_child_a = comment_child.comments.first
        comment_child_b = comment_child.comments.last

        expect(the_comment.get_comments).to contain_exactly(
          ["#{comment_child.id}", comment_child.comments],
          ["#{comment_child_a.id}", comment_child_a.comments] ,
          ["#{comment_child_b.id}", comment_child_b.comments]
        )
      end

      it 'when it has no associated comments' do
        the_comment.save
        expect(the_comment.get_comments).to contain_exactly()
      end
    end

  end
end
