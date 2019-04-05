class RentExpirationMailer < ApplicationJob
  def perform
    UserMailer.rent_expiration_email.deliver_now
  end
end
