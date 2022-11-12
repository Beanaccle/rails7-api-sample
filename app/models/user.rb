# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :points, presence: true
  validates :points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
