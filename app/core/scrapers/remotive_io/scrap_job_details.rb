module Scrapers
  module RemotiveIo
    class ScrapJobDetails
      def initialize(job_link:)
        @job_link = job_link
      end

      def call
        # check if apply_link does not redirect to SO, WWR etc
        # -> return nil if is not own job ad
        # -> scrap job details
      end

      private

      attr_reader :job_link
    end
  end
end
