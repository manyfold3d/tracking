require 'grape'

$data = {}
$stats = nil

module Tracking
  class API < Grape::API
    version 'v1', using: :header, vendor: 'manyfold'
    format :json
    default_format :json

    helpers do
      def store(id, version)
        $data[id] = version.merge(time: DateTime.now)
        $stats = nil
      end

      def calculate_stats
        recent = $data.select{ |k,v| v[:time] >= (Date.today - 7) }
        {
          instances: recent.size,
          versions: recent.group_by{ |k,v| v["app"] }.map{|k,v| [k, v.length]}.to_h
        }
      end
    end

    desc "Store tracking data for a single ID"
    params do
      requires :id, type: String
      requires :version, type: Hash do
        requires :app, type: String
        requires :sha, type: String
      end
    end
    post do
      store(params["id"], params["version"])
    end

    desc "Send browser visitors to docs"
    get do
      redirect 'https://manyfold.app'
    end

    desc "Get aggregated usage stats"
    get :stats do
      $stats ||= calculate_stats
    end
  end
end
