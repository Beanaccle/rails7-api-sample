module Products
  class Update
    def initialize(user, product)
      @user = user
      @product = product
    end

    def call(params)
      # NOTE: 自分の商品ではない場合、更新できる商品はない
      raise ActiveRecord::RecordNotFound if @user != @product.user

      @product.update!(params)
    end
  end
end
