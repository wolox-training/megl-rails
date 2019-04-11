class RentExpirationMailerJob < ApplicationJob
  def perform
    Rent.expired.each do |rent|
      UserMailer.rent_expiration_email(rent.user, rent).deliver_now
    end
  end
end
