module Scrapers
  module StackOverflow
    class << self
      def scrap_data
        puts REMOTE_JOBS_URL

        # fetch all urls
        # open each page and scrap data
      end

      private

      def fetch_urls
        # fetch urls from that page
        # should I go to the next page?
        # return all links
      end
    end
  end
end
