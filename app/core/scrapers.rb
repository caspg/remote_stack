module Scrapers
  class << self
    # rubocop:disable Metrics/MethodLength
    def run_scraper(scraper_module:, job_origin_name:)
      Rails.logger.info("starting Scrapers::#{scraper_module}")
      start = Time.now

      job_posts = scraper_module.scrap_and_create_job_posts(
        last_origin_id: last_origin_id(job_origin_name),
      )

      JobPostSearch.refresh_materialized_view

      elapsed = Time.now - start
      size = job_posts.size

      Rails.logger.info(
        "Scrapers::#{scraper_module} run for #{elapsed} seconds and created #{size} job posts.",
      )
    end
    # rubocop:enable Metrics/MethodLength

    private

    def last_origin_id(job_origin_name)
      JobPost.most_recent_for_origin(job_origin_name)&.origin_id
    end
  end
end
