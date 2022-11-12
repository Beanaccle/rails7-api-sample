module Users
  class DestroyProduct
    def initialize(user)
      @user = user
    end

    def call(product_id)
      product = @user.products.find(product_id)
      product.destroy!
    end
  end
end
