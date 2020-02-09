module Scrapers
  module RemotiveIo
    class ScrapAndCreateJobPosts
      def initialize(last_origin_id:)
        @last_origin_id = last_origin_id
      end

      def call
        job_links
          .map { |job_link| scrap_job_details(job_link) }
          .filter(&:present?)
          .map { |job_details| create_job_post(job_details) }
      end

      private

      attr_reader :last_origin_id

      def job_links
        ::Scrapers::RemotiveIo::ScrapJobsLinks.new(last_origin_id: last_origin_id).call
      end

      def scrap_job_details(job_link)
        # don't spam
        sleep(1)
        ::Scrapers::RemotiveIo::ScrapJobDetails.new(job_link: job_link).call
      end

      def create_job_post(job_details)
        ::Scrapers::CreateJobPost.new(job_details: job_details).call!
      end
    end
  end
end
