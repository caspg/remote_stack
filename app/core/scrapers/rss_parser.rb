module Scrapers
  class RssParser
    def initialize(last_guid:)
      @last_guid = last_guid
    end

    def call
      items.map do |item|
        ::Scrapers::RssItem.new(
          id: item_id(item),
          title: item.title,
          link: item.link,
          description: item.description,
          categories: item.categories.map(&:content),
          publication_datetime: item.pubDate.to_datetime,
        )
      end
    end

    private

    attr_reader :last_guid

    def item_id(item)
      item.guid.content
    end

    def items
      sorted_items.take_while do |item|
        item_id(item).to_s != last_guid
      end
    end

    def sorted_items
      feed.items.sort_by(&:pubDate).reverse
    end

    def feed
      # TODO(kacper): check if all good here
      url_content = Net::HTTP.get(URI(rss_feed_url))
      ::RSS::Parser.parse(url_content)
    end

    def rss_feed_url
      raise 'Missing feed url'
    end
  end
end
