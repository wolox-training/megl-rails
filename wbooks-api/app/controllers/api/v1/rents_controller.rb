module Api
  module V1
    class RentsController < ApiController
      def index
        render_paginated Rent.all, each_serializer: RentSerializer
      end

      def show
        render json: Rent.find(params[:id]), serializer: RentSerializer
      end

      def create
        rent = Rent.new(rent_params)
        if rent.save
          render json: rent, serializer: RentSerializer
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
