module Api
  module V1
    class RentsController < ApiController
      def index
        rents = Rent.all
        render_paginated rents, each_serializer: RentSerializer
      end

      def show
        rent = Rent.find(params[:id])
        render json: rent, serializer: RentSerializer
      end

      def create
        rent = Rent.new(rent_params)
        if rent.save
          UserMailer.rent_creation_email(current_user, rent).deliver_later
          head :ok
        else
          head :bad_request
        end
      end

      private

      def rent_params
        params.require(:rent).permit(:user_id, :book_id, :rented_from, :rented_to, :returned_at)
      end
    end
  end
end
