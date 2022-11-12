require 'rails_helper'

RSpec.describe Users::Build do
  describe "#call" do
    it "10_000 points given to the user" do
      user = User.new
      expect {
        described_class.new(user).call
      }.to change(user, :points).from(0).to(10_000)
    end
  end
end
