require 'rss'

module Scrapers
  module StackOverflow
    class ParseRss < ::Scrapers::RssParser
      RSS_FEED_URL = 'https://stackoverflow.com/jobs/feed?r=true'.freeze

      def initialize(last_origin_id:, limit:)
        super(last_guid: last_origin_id, limit: limit)
      end

      def call
        super
      end

      private

      def rss_feed_url
        RSS_FEED_URL
      end
    end
  end
end
