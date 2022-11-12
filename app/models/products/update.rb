module Products
  class Update
    def initialize(user)
      @user = user
    end

    def call(product_id, params)
      product = @user.products.find(product_id)
      product.update!(params)
      product
    end
  end
end
