# frozen_string_literal: true

module Users
  class ChangeProductOwner
    def initialize(user)
      @user = user
    end

    def call(product)
      product.user = @user
      product.save!
    end
  end
end
