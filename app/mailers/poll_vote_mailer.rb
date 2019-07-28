class PollVoteMailer < ApplicationMailer
  def thanks_for_your_vote(user)
    @user = user

    mail to: user.email, subject: "Thanks for your vote !"
  end
end
