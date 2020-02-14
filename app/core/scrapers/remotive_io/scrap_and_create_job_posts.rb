module Scrapers
  module RemotiveIo
    class ScrapAndCreateJobPosts
      def initialize(last_origin_id:, job_origin_id:, limit:)
        @last_origin_id = last_origin_id
        @job_origin_id = job_origin_id
        @limit = limit
      end

      def call
        job_links.each do |job_link|
          job_details = scrap_job_details(job_link)
          next if job_details.nil?

          create_job_post(job_details)
        end
      end

      private

      attr_reader :last_origin_id, :job_origin_id, :limit

      def job_links
        ::Scrapers::RemotiveIo::ScrapJobsLinks.new(
          last_origin_id: last_origin_id,
          limit: limit,
        ).call
      end

      def scrap_job_details(job_link)
        # don't spam
        sleep(1)

        ::Scrapers::RemotiveIo::ScrapJobDetails.new(
          job_link: job_link,
          job_origin_id: job_origin_id,
        ).call
      end

      def create_job_post(job_details)
        ::Scrapers::CreateJobPost.new(job_details: job_details).call!
      end
    end
  end
end
