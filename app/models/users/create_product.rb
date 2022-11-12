module Users
  class CreateProduct
    def initialize(user)
      @user = user
    end

    def call(params)
      @user.products.create!(params)
    end
  end
end
