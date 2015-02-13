describe User do
  let(:the_user){
    build(:user)
  }

  context 'must respond to' do
    it 'email' do
      expect(the_user).to respond_to (:email)
    end
    it 'encrypted_password' do
      expect(the_user).to respond_to (:encrypted_password)
    end
    it 'provider' do
      expect(the_user).to respond_to (:provider)
    end
    it 'uid' do
      expect(the_user).to respond_to (:uid)
    end
    it 'created_at' do
      expect(the_user).to respond_to (:created_at)
    end
    it 'updated_at' do
      expect(the_user).to respond_to (:updated_at)
    end
    it 'comments' do
      expect(the_user).to respond_to (:comments)
    end
    it 'stories' do
      expect(the_user).to respond_to (:stories)
    end
  end

  it '' do
    expect(the_user).to be_valid
  end
end
