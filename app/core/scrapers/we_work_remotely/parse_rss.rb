require 'rss'

module Scrapers
  module WeWorkRemotely
    class ParseRss < ::Scrapers::RssParser
      RSS_FEED_URL = 'https://weworkremotely.com/categories/remote-programming-jobs.rss'.freeze

      def initialize(last_origin_id:, limit:)
        super(last_guid: last_origin_id, limit: limit)
      end

      def call
        super
      end

      private

      def item_id(item)
        Digest::MD5.hexdigest(item.guid.content)
      end

      def rss_feed_url
        RSS_FEED_URL
      end
    end
  end
end
