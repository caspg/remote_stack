module Scrapers
  module WeWorkRemotely
    class << self
      def scrap_and_create_job_posts(last_origin_id:)
        ::Scrapers::ScrapRssAndCreateJobPosts.new(
          last_origin_id: last_origin_id,
          rss_parser: ::Scrapers::WeWorkRemotely::ParseRss,
          job_details_scraper: ::Scrapers::WeWorkRemotely::ScrapJobDetails,
          job_origin_id: job_origin_id,
        ).call
      end

      def job_origin_id
        JobOrigin.find_by(name: JobOrigin::WE_WORK_REMOTELY).id
      end
    end
  end
end
