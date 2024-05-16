require 'grape'

module Tracking
  class API < Grape::API
    version 'v1', using: :header, vendor: 'manyfold'
    format :json

    helpers do
    end

    desc "Store tracking data for a single ID"
    post do
    end

    desc "Send browser visitors to docs"
    get do
    end

    desc "Get aggregated usage stats"
    get :stats do
    end
  end
end
