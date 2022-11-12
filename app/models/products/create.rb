module Products
  class Create
    def initialize(user)
      @user = user
    end

    def call(params)
      @user.products.create!(params)
    end
  end
end
