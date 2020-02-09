module Scrapers
  module WeWorkRemotely
    class ScrapJobDetails < ::Scrapers::RssItemDetailsScraper
      def initialize(rss_feed_item:)
        @rss_feed_item = rss_feed_item
      end

      def call
        ::Scrapers::ScrappedJobDetails.new(
          id: rss_feed_item.id,
          title: title,
          company_name: company_name,
        )
      end

      private

      def title
        document.css('.listing-header h1')
                .first
                &.content
                &.strip
      end

      def company_name
        document.css('.company-card h2')
                .first
                &.content
                &.strip
      end
    end
  end
end
