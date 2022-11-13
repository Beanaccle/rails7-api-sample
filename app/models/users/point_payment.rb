module Users
  class PointPayment
    def initialize(buyer)
      @buyer = buyer
    end

    def call(seller, points)
      raise NotEnoughPointsError if @buyer.points < points

      ActiveRecord::Base.transaction do
        @buyer.points -= points
        @buyer.save!

        seller.points += points
        seller.save!
      end
    end
  end
end
