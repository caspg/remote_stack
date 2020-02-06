module Scrapers
  class BaseScraper
    def initialize(url)
      @url = url
    end

    def xpath(path)
      document.xpath(path)
    end

    def css(selector)
      document.css(selector)
    end

    private

    attr_reader :url

    def document
      @document ||= begin
        # TODO(kacper): maybe check if returns 200
        #
        raw_document = HTTParty.get(url)
        Nokogiri::HTML(raw_document.body)
      end
    end
  end
end
