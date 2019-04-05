module Api
  module V1
    class ApiController < ApplicationController
      include Wor::Paginate
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pundit

      before_action :authenticate_user!

      protect_from_forgery with: :null_session
    end
  end
end
