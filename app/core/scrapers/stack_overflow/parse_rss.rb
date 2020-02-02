require 'rss'

module Scrapers
  module StackOverflow
    class ParseRss
      FeedItem = Struct.new(
        :id,
        :title,
        :link,
        :description,
        :categories,
        keyword_init: true,
      )

      RSS_FEED_URL = 'https://stackoverflow.com/jobs/feed?r=true'.freeze

      def initialize(last_parsed_id:)
        @last_parsed_id = last_parsed_id.to_s
      end

      def call
        items.map do |item|
          FeedItem.new(
            id: item.guid.content,
            title: item.title,
            link: item.link,
            description: item.description,
            categories: item.categories.map(&:content),
          )
        end
      end

      private

      attr_reader :last_parsed_id

      def items
        sorted_items.take_while do |item|
          item.guid.content.to_s != last_parsed_id
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
