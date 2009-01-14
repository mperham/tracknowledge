if defined? Fiveruns::Dash
  ENV['DASH_UPDATE'] = 'https://dash-collector-staging.fiveruns.com'
  Fiveruns::Dash::Rails.start :production => '13eaebd052c0ea96b0f63759bcd0ceb46a74ab02'
end
