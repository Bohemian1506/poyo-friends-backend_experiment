module Api
  module V1
    class HealthController < ApplicationController
      def index
        render json: { status: "ok", message: "APIが正常に動作しています" }
      end
    end
  end
end
