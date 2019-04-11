class UserMailer < ApplicationMailer
  def rent_creation_email(user, rent)
    send_email(user, rent)
  end

  def rent_expiration_email(user, rent)
    send_email(user, rent)
  end

  private

  def locale(user)
    I18n.locale = user.locale || I18n.default_locale
  end

  def send_email(user, rent)
    @rent = rent

    locale(user)

    mail(to: user.email, subject: t('.subject'))
  end
end
