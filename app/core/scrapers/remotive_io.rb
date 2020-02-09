module Scrapers
  module RemotiveIo
    BASE_HOST = 'remotive.io'.freeze
    ORIGIN_NAME = 'RemotiveIo'.freeze

    class << self
      def build_url(path)
        return nil if path.nil?

        URI::HTTPS.build(host: BASE_HOST, path: path).to_s
      end

      def scrap_and_create_job_posts
        ::Scrapers::RemotiveIo::ScrapAndCreateJobPosts.new.call
      end
    end
  end
end
