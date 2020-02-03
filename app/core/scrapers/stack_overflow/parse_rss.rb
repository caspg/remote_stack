require 'rss'

module Scrapers
  module StackOverflow
    class ParseRss
      RSS_FEED_URL = 'https://stackoverflow.com/jobs/feed?r=true'.freeze

      def initialize(last_origin_id:)
        @last_origin_id = last_origin_id.to_s
      end

      def call
        items.map do |item|
          ::Scrapers::RssFeedItem.new(
            id: item.guid.content,
            title: item.title,
            link: item.link,
            description: item.description,
            categories: item.categories.map(&:content),
            publication_datetime: item.pubDate.to_datetime,
          )
        end
      end

      private

      attr_reader :last_origin_id

      def items
        sorted_items.take_while do |item|
          item.guid.content.to_s != last_origin_id
        end
      end

      def sorted_items
        feed.items.sort_by(&:pubDate).reverse
      end

      def feed
        url_content = Net::HTTP.get(URI(RSS_FEED_URL))
        ::RSS::Parser.parse(url_content)
      end
    end
  end
end
