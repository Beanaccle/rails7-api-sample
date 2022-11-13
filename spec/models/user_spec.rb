# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'associations' do
    let(:user) { build(:user) }

    it { expect(user).to have_many(:products).dependent(:destroy) }

    it {
      expect(user).to have_many(:seller_payment_histories).with_foreign_key(:seller_id)
                                                          .inverse_of(:seller)
                                                          .dependent(:restrict_with_exception)
    }

    it {
      expect(user).to have_many(:buyer_payment_histories).with_foreign_key(:buyer_id)
                                                         .inverse_of(:buyer)
                                                         .dependent(:restrict_with_exception)
    }
  end

  describe 'validations' do
    let(:user) { build(:user) }

    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email).scoped_to(:provider).case_insensitive }
    it { expect(user).to validate_presence_of(:password) }
    it { expect(user).to validate_numericality_of(:points).only_integer.is_greater_than_or_equal_to(0) }
  end
end
