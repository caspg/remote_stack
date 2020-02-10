module Scrapers
  class StackOverflowWorker
    include Sidekiq::Worker

    sidekiq_options retry: 0

    def perform
      ::Scrapers.run_scraper(
        scraper_module: StackOverflow,
        job_origin_name: JobOrigin::STACK_OVERFLOW,
      )
    end
  end
end
