module Api
  module V1
    module Auth
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        private

        def respond_with(resource, _opts = {})
          if resource.persisted?
            render json: {
              user: UserSerializer.new(resource).serializable_hash[:data][:attributes],
              message: 'Signed up successfully.'
            }, status: :ok
          else
            render json: {
              errors: resource.errors.full_messages
            }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end