class UserMailer < ApplicationMailer
  def rent_creation_email(user, rent)
    @rent = rent

    locale(user)

    mail(to: user.email, subject: t('.subject'))
  end

  def rent_expiration_email
    rents = Rent.expired

    rents.each do |rent|
      @rent = rent

      locale(@rent.user.locale)
      mail(to: @rent.user.email, subject: t('.subject'))
    end
  end

  private

  def locale(user)
    I18n.locale = user.locale || I18n.default_locale
  end
end
