module Scrapers
  module StackOverflow
    class << self
      def scrap_and_create_job_posts(last_origin_id:, limit: nil)
        ::Scrapers::ScrapRssAndCreateJobPosts.new(
          last_origin_id: last_origin_id,
          rss_parser: ::Scrapers::StackOverflow::ParseRss,
          job_details_scraper: ::Scrapers::StackOverflow::ScrapJobDetails,
          job_origin_id: job_origin_id,
          limit: limit,
        ).call
      end

      def job_origin_id
        JobOrigin.find_by(name: JobOrigin::STACK_OVERFLOW).id
      end
    end
  end
end
