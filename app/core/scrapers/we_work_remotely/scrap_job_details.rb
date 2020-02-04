module Scrapers
  module WeWorkRemotely
    class ScrapJobDetails < ::Scrapers::JobDetailsScraper
      def initialize(rss_feed_item:)
        @rss_feed_item = rss_feed_item
      end

      def call
        ::Scrapers::ScrappedJobDetails.new(
          id: rss_feed_item.id,
          title: title,
          company: company,
        )
      end

      private

      def title
        document.css('.listing-header h1')
                .first
                &.content
                &.strip
      end

      def company
        document.css('.company-card h2')
                .first
                &.content
                &.strip
      end
    end
  end
end
