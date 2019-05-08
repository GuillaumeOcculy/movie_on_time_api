class NotificationsMailer < ApplicationMailer
  def movie_released(recipient, movie)
    @recipient = recipient
    @movie = movie

    mail to: recipient.email, subject: "#{movie.title} is released !"
  end
end
