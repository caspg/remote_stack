module Scrapers
  class ScrapRssAndCreateJobPosts
    def initialize(last_origin_id:, rss_parser:, origin_name:, job_details_scraper:)
      @last_origin_id = last_origin_id
      @rss_parser = rss_parser
      @origin_name = origin_name
      @job_details_scraper = job_details_scraper
    end

    def call
      parse_rss_feed_items
        .map { |rss_feed_item| scrap_and_prepare_data(rss_feed_item) }
        .map { |data| create_job_post(data) }
    end

    private

    attr_reader :last_origin_id, :rss_parser, :origin_name, :job_details_scraper

    def parse_rss_feed_items
      rss_parser.new(last_origin_id: last_origin_id).call
    end

    def scrap_and_prepare_data(rss_feed_item)
      {
        rss_feed_item: rss_feed_item,
        scraped_job_details: scrap_job_details(rss_feed_item),
      }
    end

    def scrap_job_details(rss_feed_item)
      # don't spam
      sleep(1)
      job_details_scraper.new(rss_feed_item: rss_feed_item).call
    end

    def create_job_post(arguments)
      arguments = arguments.merge(origin_name: origin_name)
      ::Scrapers::CreateJobPost.new(arguments).call!
    end
  end
end
