module Scrapers
  class JobDetailsScraper
    def initialize(rss_feed_item:)
      @rss_feed_item = rss_feed_item
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
  end
end
