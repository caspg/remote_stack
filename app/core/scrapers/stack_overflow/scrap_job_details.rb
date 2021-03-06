module Scrapers
  module StackOverflow
    class ScrapJobDetails < ::Scrapers::RssItemDetailsScraper
      def initialize(rss_feed_item:)
        super(rss_feed_item: rss_feed_item)
      end

      def call
        ::Scrapers::ScrappedJobDetails.new(
          id: rss_feed_item.id,
          title: title,
          salary: salary,
          company_name: company_name || alternative_company_name,
          benefits: benefits,
          apply_url: rss_feed_item.link,
        )
      end

      private

      def title
        document.css('.fs-headline1')
                .first
                &.content
                &.strip
      end

      def salary
        document.css('.-salary')
                .first
                &.content
                &.strip
      end

      def company_name
        document.css('header [href^="/jobs/companies/"]')
                .find { |i| i.content.present? }
                &.content
      end

      def alternative_company_name
        document.css('header .employer')
                .find { |i| i.content.present? }
                &.content
      end

      def benefits
        document.css('.-benefits')
                .first
                &.content
                &.strip
      end
    end
  end
end
