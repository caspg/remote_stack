module Scrapers
  module StackOverflow
    class ScrapJobDetails
      ScrapedJobDetails = Struct.new(
        :id,
        :title,
        :salary,
        :company,
        :benefits,
        keyword_init: true,
      )

      def initialize(rss_feed_item:)
        @rss_feed_item = rss_feed_item
      end

      def call
        ScrapedJobDetails.new(
          id: rss_feed_item.id,
          title: title,
          salary: salary,
          company: company,
          benefits: benefits,
        )
      end

      private

      attr_reader :rss_feed_item

      def document
        @document ||= begin
          # TODO(kacper): maybe check if returns 200
          raw_document = Net::HTTP.get(URI(rss_feed_item.link))
          Nokogiri::HTML(raw_document)
        end
      end

      def salary
        document.css('.-salary')
                .first
                &.content
                &.strip
      end

      def company
        document.css('header [href^="/jobs/companies/"]')
                .find { |i| i.content.present? }
                &.content
      end

      def benefits
        document.css('.-benefits')
                .first
                &.content
                &.strip
      end

      def title
        document.css('.fs-headline1')
                .first
                &.content
                &.strip
      end
    end
  end
end
