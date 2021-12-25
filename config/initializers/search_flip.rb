SearchFlip::Config[:environment] = Rails.env
SearchFlip::Config[:base_url] = ENV.fetch("ES_URL")