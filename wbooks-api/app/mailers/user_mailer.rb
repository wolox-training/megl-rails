class UserMailer < ApplicationMailer
  def rent_creation_email
    user = User.find(params[:user_id])
    @rent = Rent.find(params[:rent_id])

    I18n.locale = user.locale || I18n.default_locale

    mail(to: user.email, subject: t(:subject))
  end
end
