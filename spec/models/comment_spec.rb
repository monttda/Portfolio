describe Comment do
  let(:the_comment){
    build(:comment)
  }

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
  end

  it '' do
    expect(the_comment).to be_valid
  end
end
