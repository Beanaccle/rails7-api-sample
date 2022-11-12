require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  describe "validations" do
    let(:user) { build(:user) }

    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email).scoped_to(:provider).case_insensitive }
    it { expect(user).to validate_presence_of(:password) }
  end
end
