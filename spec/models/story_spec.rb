describe Story do
  let(:the_story){
    build(:story)
  }

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
  end

  it '' do
    expect(the_story).to be_valid
  end
end
