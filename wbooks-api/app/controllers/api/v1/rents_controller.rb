module Api
  module V1
    class RentsController < ApiController
      def index
        render_paginated Rent.all, each_serializer: RentSerializer
      end

      def show
        render json: Rent.find(params[:id]), serializer: RentSerializer
      rescue ActiveRecord::RecordNotFound
        head :not_found
      end

      def create
        rent = Rent.new(rent_params)

        unless rent.save
          head :bad_request
          return
        end

        UserMailer.rent_creation_email(current_user, rent).deliver_later

        render json: rent, status: :created, serializer: RentSerializer
      end

      private

      def rent_params
        params.require(:rent).permit(:user_id, :book_id, :rented_from, :rented_to, :returned_at)
      end
    end
  end
end
