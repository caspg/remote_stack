module Scrapers
  module StackOverflow
    SO_ORIGIN_NAME = 'Stack Overflow'.freeze

    class << self
      def scrap_and_create_job_posts(last_origin_id:)
        parse_rss_feed_items(last_origin_id)
          .map { |rss_feed_item| scrap_and_prepare_data(rss_feed_item) }
          .map { |data| create_job_post(data) }
      end

      private

      def parse_rss_feed_items(last_origin_id)
        ::Scrapers::StackOverflow::ParseRss.new(last_origin_id: last_origin_id).call
      end

      def scrap_and_prepare_data(rss_feed_item)
        {
          # TODO(kacper): do something with it
          origin_name: SO_ORIGIN_NAME,
          rss_feed_item: rss_feed_item,
          scraped_job_details: scrap_job_details(rss_feed_item),
        }
      end

      def scrap_job_details(rss_feed_item)
        # don't spam
        sleep(1)

        ::Scrapers::StackOverflow::ScrapJobDetails.new(rss_feed_item: rss_feed_item).call
      end

      def create_job_post(arguments)
        ::Scrapers::CreateJobPost.new(arguments).call!
      end
    end
  end
end
