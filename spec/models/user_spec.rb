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
end
