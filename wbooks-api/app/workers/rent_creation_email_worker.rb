class RentCreationEmailWorker
  include Sidekiq::Worker

  def perform(*args)
    UserMailer.with(user_id: args[0], rent_id: args[1]).rent_creation_email.deliver_now
  end
end
