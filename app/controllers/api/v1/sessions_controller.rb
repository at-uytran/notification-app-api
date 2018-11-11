module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: user_params[:email].downcase)
        if user && user.authenticate(user_params[:password])
          user.update_auth_token
          response.headers['Authorization'] = user.auth_digest
          render json: user, status: :ok
        else
          render json: { message: I18n.t('controller.session.invalid') }, status: :unauthorized
        end
      end

      def update
        @actor.update_auth_token
        response.headers['Authorization'] = @actor.auth_digest
        render json: @actor
      end

      def destroy
        @actor.remove_auth_token
        render json: { message: I18n.t('controller.session.logout') }, status: :ok
      end
    end
  end
end
