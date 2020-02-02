module Scrapers
  module StackOverflow
    class << self
      def scrap_data(last_parsed_id)
        parsed_rss_feed_items(last_parsed_id).map do |rss_feed_item|
          [
            rss_feed_item,
            scrap_job_details(rss_feed_item)
          ]
        end
      end

      private

      def parsed_rss_feed_items(last_parsed_id)
        ::Scrapers::StackOverflow::ParseRss.new(last_parsed_id: last_parsed_id).call
      end

      def scrap_job_details(rss_feed_item)
        sleep(1)

        ::Scrapers::StackOverflow::ScrapJobDetails.new(rss_feed_item: rss_feed_item).call
      end
    end
  end
end
