# frozen_string_literal: true

module Users
  class Build
    DEFAULT_POINTS = 10_000

    def initialize(user)
      @user = user
    end

    def call
      @user.points = DEFAULT_POINTS
    end
  end
end
