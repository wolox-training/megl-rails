class UserMailer < ApplicationMailer
  def rent_creation_email(user, rent)
    @rent = rent

    mail(to: user.email, subject: 'wbooks-api - Rent creation')
  end
end
