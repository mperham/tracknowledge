class TrackMailer < ActionMailer::Base
  def summary(track)
    recipients  'admin@tracknowledge.org'
    from        "#{track.added_by} <#{track.user_email}>"
    subject     "New #{track.status == 0 ? 'unapproved' : ''} track: #{track.name}"
    body        track.attributes.map {|k, v| v ? "#{k.titleize}: #{v}" : nil}.compact.join("\n") + "\n\n" + track.details.attributes.map {|k, v| "#{k.upcase}: #{v}"}.join("\n")
  end
end