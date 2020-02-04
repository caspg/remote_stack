module Scrapers
  module StackOverflow
    ORIGIN_NAME = 'Stack Overflow'.freeze

    class << self
      def scrap_and_create_job_posts(last_origin_id:)
        ::Scrapers::ScrapRssAndCreateJobPosts.new(
          last_origin_id: last_origin_id,
          origin_name: ORIGIN_NAME,
          rss_parser: ::Scrapers::StackOverflow::ParseRss,
          job_details_scraper: ::Scrapers::StackOverflow::ScrapJobDetails,
        ).call
      end
    end
  end
end
