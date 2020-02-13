module Scrapers
  module RemotiveIo
    BASE_HOST = 'remotive.io'.freeze

    class << self
      def build_url(path)
        return nil if path.nil?

        URI::HTTPS.build(host: BASE_HOST, path: path).to_s
      end

      def scrap_and_create_job_posts(last_origin_id:, limit: nil)
        ::Scrapers::RemotiveIo::ScrapAndCreateJobPosts.new(
          last_origin_id: last_origin_id,
          job_origin_id: job_origin_id,
          limit: limit,
        ).call
      end

      def job_origin_id
        JobOrigin.find_by(name: JobOrigin::REMOTEIVE_IO).id
      end
    end
  end
end
