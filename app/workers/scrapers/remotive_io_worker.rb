module Scrapers
  class RemotiveIoWorker
    include Sidekiq::Worker

    sidekiq_options retry: 0

    def perform
      ::Scrapers.run_scraper(
        scraper_module: RemotiveIo,
        job_origin_name: JobOrigin::STACK_OVERFLOW,
      )
    end
  end
end
