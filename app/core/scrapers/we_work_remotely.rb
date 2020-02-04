module Scrapers
  module WeWorkRemotely
    ORIGIN_NAME = 'We Work Remotely'.freeze

    class << self
      def scrap_and_create_job_posts(last_origin_id:)
        ::Scrapers::ScrapAndCreateJobPosts.new(
          last_origin_id: last_origin_id,
          origin_name: ORIGIN_NAME,
          rss_parser: ::Scrapers::WeWorkRemotely::ParseRss,
          job_details_scraper: ::Scrapers::WeWorkRemotely::ScrapJobDetails,
        ).call
      end
    end
  end
end
