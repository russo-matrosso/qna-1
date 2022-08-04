class NotificationsJob < ApplicationJob
  queue_as :default

  def perform(answer)
    Services::Notifications.new(answer).send_notification
  end
end