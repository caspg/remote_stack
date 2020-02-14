module Scrapers
  class ScrapRssAndCreateJobPosts
    def initialize(last_origin_id:, rss_parser:, job_origin_id:, job_details_scraper:, limit:)
      @last_origin_id = last_origin_id
      @rss_parser = rss_parser
      @job_origin_id = job_origin_id
      @job_details_scraper = job_details_scraper
      @limit = limit
    end

    def call
      parse_rss_feed_items.each do |rss_feed_item|
        job_post_details = scrap_and_prepare_params(rss_feed_item)
        create_job_post(job_post_details)
      end
    end

    private

    attr_reader :last_origin_id, :rss_parser, :job_origin_id, :job_details_scraper, :limit

    def parse_rss_feed_items
      rss_parser.new(last_origin_id: last_origin_id, limit: limit).call
    end

    def scrap_and_prepare_params(rss_feed_item)
      scraped_job_details = scrap_job_details(rss_feed_item)
      normalize_job_details(rss_feed_item, scraped_job_details)
    end

    def scrap_job_details(rss_feed_item)
      # don't spam
      sleep(1)
      job_details_scraper.new(rss_feed_item: rss_feed_item).call
    end

    def create_job_post(job_details)
      ::Scrapers::CreateJobPost.new(job_details: job_details).call!
    end

    # rubocop:disable Metrics/MethodLength
    def normalize_job_details(rss_feed_item, scraped_job_details)
      ::Scrapers::ScrappedJobDetails.new(
        id: rss_feed_item.id,
        job_origin_id: job_origin_id,
        title: scraped_job_details.title || rss_feed_item.title,
        company_name: scraped_job_details.company_name,
        benefits: scraped_job_details.benefits,
        salary: scraped_job_details.salary,
        apply_url: scraped_job_details.apply_url,
        origin_url: rss_feed_item.link,
        publication_datetime: rss_feed_item.publication_datetime,
        description: rss_feed_item.description,
        categories: rss_feed_item.categories,
      )
    end
    # rubocop:enable Metrics/MethodLength
  end
end
