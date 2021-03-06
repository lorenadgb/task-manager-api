require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it { expect(user).to respond_to(:email) }
  it { expect(user).to respond_to(:password) }
  it { expect(user).to respond_to(:password_confirmation) }
  it { expect(user).to be_valid }

  it { expect(user).to validate_presence_of(:email) }
  it { expect(user).to validate_uniqueness_of(:email).case_insensitive }
  it { expect(user).to validate_confirmation_of(:password) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#info' do
    it 'returns email, created_at and a Token' do
      user.save!
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')

      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xyzTOKEN")
    end
  end

  describe '#generate_authentication_token!' do
    it 'generates a unique auth_token' do
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')
      user.generate_authentication_token!

      expect(user.auth_token).to eq('abc123xyzTOKEN')
    end

    it 'generates another auth_token when the current auth token already has been taken' do
      allow(Devise).to receive(:friendly_token).and_return('abc123tokenxyz', 'abc123tokenxyz', 'abcxYZ')
      existing_user = create(:user)

      user.generate_authentication_token!

      expect(user.auth_token).not_to eq(existing_user.auth_token)
    end

  end
end
