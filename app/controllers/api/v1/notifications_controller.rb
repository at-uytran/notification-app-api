module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :load_notification, only: :show

      def index
        @notifications = Notification.lastest
        unread = Notification.unread.size
        render json: {message: "", data: {notifications: @notifications, unread: unread}}, status: 200
      end

      def show
        render json: {data: {notification: @notification}}
      end

      def create
        notification = Notification.new(notification_params)
        notification.save
      end

      private
      def notification_params
        params.require(:notification).permit(:content)
      end

      def load_notification
        @notification = Notification.find_by id: params[:id]
      end
    end
  end
end
