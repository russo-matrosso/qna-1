class Services::Notifications
  def initialize(answer)
    @answer = answer
  end

  def send_notification
    user = @answer.user
    NotificationsMailer.notification(user, @answer).deliver_later
  end
end