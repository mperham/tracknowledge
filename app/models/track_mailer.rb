class TrackMailer < ActionMailer::Base
  def summary(track)
    recipients  'admin@tracknowledge.org'
    from        "#{track.added_by} <#{track.user_email}>"
    subject     "New track: #{track.name}"
    body        track.inspect
  end
end