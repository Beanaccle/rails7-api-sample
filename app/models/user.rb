# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :products, dependent: :destroy
  has_many :seller_payment_histories, class_name: "PaymentHistory", foreign_key: :seller_id, dependent: :restrict_with_exception
  has_many :buyer_payment_histories, class_name: "PaymentHistory", foreign_key: :buyer_id, dependent: :restrict_with_exception

  validates :points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
