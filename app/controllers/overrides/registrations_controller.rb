module Overrides
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    private

    def build_resource
      super
      Users::Build.new(@resource).call
    end
  end
end
