class UserMailer < ApplicationMailer
  def rent_creation_email
    user = User.find(params[:user_id])
    @rent = Rent.find(params[:rent_id])

    mail(to: user.email, subject: 'wbooks-api - Rent creation')
  end
end
