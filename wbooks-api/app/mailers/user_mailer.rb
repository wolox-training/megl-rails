class UserMailer < ApplicationMailer
  def rent_creation_email(user, rent)
    @rent = rent

    I18n.locale = user.locale || I18n.default_locale

    mail(to: user.email, subject: t(:subject))
  end
end
