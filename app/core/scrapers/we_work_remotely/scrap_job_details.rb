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
          apply_url: filtered_apply_url || rss_feed_item.link,
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

      def filtered_apply_url
        @filtered_apply_url ||=
          ::Scrapers::FilterApplyUrl.new(apply_url: apply_url).call
      end

      def apply_url
        document.css('.apply_tooltip a').first&.attribute('href')&.value
      end
    end
  end
end
